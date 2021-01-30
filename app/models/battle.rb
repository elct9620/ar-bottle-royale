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
  include AASM

  belongs_to :avatar1, class_name: 'Avatar'
  belongs_to :avatar2, class_name: 'Avatar'

  after_create :notify_players

  aasm column: :state do
    state :created, initial: true
    state :joined
    state :fighting
    state :ended
    state :cancelled

    event :join do
      transitions from: :created, to: :joined
      transitions from: :joined, to: :fighting
    end

    event :finish do
      transitions from: :fighting, to: :ended
    end

    event :cancel do
      transitions from: %i[created joined], to: :cancelled
    end
  end

  private

  def notify_players
    PlayerChannel.broadcast_to(avatar1.user, action: 'battle:created')
    PlayerChannel.broadcast_to(avatar2.user, action: 'battle:created')
  end
end
