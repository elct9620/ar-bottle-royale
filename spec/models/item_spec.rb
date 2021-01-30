# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  asset_name :string
#  icon_name  :string
#  name       :string
#  type       :string
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_items_on_type_and_id  (type,id)
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
