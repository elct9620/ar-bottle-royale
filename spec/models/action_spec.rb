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
require 'rails_helper'

RSpec.describe Action, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
