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
FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
  end
end
