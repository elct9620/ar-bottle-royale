# frozen_string_literal: true

class BattleAttackService
  attr_reader :avatar

  delegate :current_battle, to: :avatar

  def initialize(avatar)
    @avatar = avatar
  end

  def perform
    avatar.transaction do
      current_battle
        .actions
        .create!(avatar: avatar, action: :damage, amount: 1)
    end
  end
end
