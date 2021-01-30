# == Schema Information
#
# Table name: battles
#
#  id         :bigint           not null, primary key
#  end_at     :datetime
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar1_id :bigint
#  avatar2_id :bigint
#
# Indexes
#
#  index_battles_on_avatar1_id  (avatar1_id)
#  index_battles_on_avatar2_id  (avatar2_id)
#
class Battle < ApplicationRecord
  MAX_TURN = 2

  include AASM

  belongs_to :avatar1, class_name: 'Avatar'
  belongs_to :avatar2, class_name: 'Avatar'
  has_many :actions, dependent: :destroy

  scope :incompleted, -> { where.not(state: %i[ended cancelled]) }

  after_create :notify_created

  aasm column: :state do
    state :created, initial: true
    state :joined
    state :fighting
    state :ended
    state :cancelled

    event :join, after_commit: :notify_started do
      transitions from: :created, to: :joined
      transitions from: :joined, to: :fighting
      transitions from: :fighting, to: :fighting
    end

    event :finish, after_commit: :notify_ended do
      after { self.end_at = Time.zone.now }

      transitions from: :fighting, to: :ended
    end

    event :cancel do
      after { self.end_at = Time.zone.now }

      transitions from: %i[created joined], to: :cancelled
    end
  end

  def foe(avatar)
    return avatar2 if avatar1 == avatar
    return avatar1 if avatar2 == avatar

    nil
  end

  def resume
    return notify_created if created? || joined?

    notify_started
  end

  private

  def notify_created
    BattleChannel.broadcast_to(avatar1.user, action: 'battle:created')
    BattleChannel.broadcast_to(avatar2.user, action: 'battle:created')
  end

  def notify_started
    return unless fighting?

    BattleChannel.broadcast_to(avatar1.user, action: 'battle:started')
    BattleChannel.broadcast_to(avatar2.user, action: 'battle:started')
  end

  def notify_ended
    BattleChannel.broadcast_to(avatar1.user, action: 'battle:ended')
    BattleChannel.broadcast_to(avatar2.user, action: 'battle:ended')
  end
end
