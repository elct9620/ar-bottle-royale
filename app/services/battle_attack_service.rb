# frozen_string_literal: true

class BattleAttackService
  attr_reader :avatar

  delegate :current_battle, to: :avatar

  def initialize(avatar)
    @avatar = avatar
  end

  def perform
    foe.with_lock do
      foe.decrement(:hp).save if foe.hp.positive?
    end
  end

  def foe
    @foe ||=
      if current_battle.avatar1 == avatar
        current_battle.avatar2
      else
        current_battle.avatar1
      end
  end
end
