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
  belongs_to :avatar1, class_name: 'Avatar'
  belongs_to :avatar2, class_name: 'Avatar'
end
