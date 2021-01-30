# == Schema Information
#
# Table name: avatars
#
#  id         :bigint           not null, primary key
#  hp         :integer          default(10)
#  latitude   :float
#  longitude  :float
#  max_hp     :integer          default(10)
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_avatars_on_user_id  (user_id)
#  location                  (latitude,longitude)
#
FactoryBot.define do
  factory :avatar do
    name { Faker::Name.name }
  end
end
