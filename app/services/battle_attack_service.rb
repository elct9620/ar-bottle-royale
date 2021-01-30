# frozen_string_literal: true

class BattleAttackService
  attr_reader :avatar

  delegate :current_battle, to: :avatar

  def initialize(avatar)
    @avatar = avatar
  end

  def foe
    @foe ||= current_battle.foe(avatar)
  end

  def damage
    [1, avatar.weapon&.value.to_i - foe.armor&.value.to_i].max
  end

  def perform
    avatar.transaction do
      current_battle
        .actions
        .create!(avatar: avatar, action: :damage, amount: damage)
    end
  end
end
