# == Schema Information
#
# Table name: actions
#
#  id         :bigint           not null, primary key
#  action     :string
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar_id  :bigint
#  battle_id  :bigint
#
# Indexes
#
#  index_actions_on_avatar_id  (avatar_id)
#  index_actions_on_battle_id  (battle_id)
#
class Action < ApplicationRecord
  belongs_to :battle
  belongs_to :avatar

  before_save :apply_effect
  after_save :check_battle
  after_commit :notify_damage
  after_commit -> { battle.refresh_player }

  private

  def apply_effect
    battle
      .foe(avatar)
      .apply_effect(action, amount)
  end

  def check_battle
    battle.finish! if battle.actions.size >= Battle::MAX_TURN
  end

  def notify_damage
    BattleChannel.broadcast_to(avatar.user, action: "#{action}:apply")
  end
end
