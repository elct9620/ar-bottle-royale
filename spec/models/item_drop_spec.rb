# == Schema Information
#
# Table name: item_drops
#
#  id         :bigint           not null, primary key
#  category   :string
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint
#
# Indexes
#
#  index_item_drops_on_category  (category)
#  index_item_drops_on_item_id   (item_id)
#
require 'rails_helper'

RSpec.describe ItemDrop, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
