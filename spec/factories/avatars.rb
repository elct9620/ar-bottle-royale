# == Schema Information
#
# Table name: avatars
#
#  id         :bigint           not null, primary key
#  hp         :integer          default(100)
#  latitude   :float
#  longitude  :float
#  max_hp     :integer          default(100)
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  armor_id   :bigint
#  user_id    :bigint
#  weapon_id  :bigint
#
# Indexes
#
#  index_avatars_on_armor_id   (armor_id)
#  index_avatars_on_user_id    (user_id)
#  index_avatars_on_weapon_id  (weapon_id)
#  location                    (latitude,longitude)
#
FactoryBot.define do
  factory :avatar do
    name { Faker::Name.name }
  end
end
