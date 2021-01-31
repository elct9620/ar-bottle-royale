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
class Avatar < ApplicationRecord
  SCAN_RANGE = 1 # 1km
  MAX_ITEM_INVENTORY = 5

  belongs_to :user
  belongs_to :weapon, class_name: 'Weapon', optional: true
  belongs_to :armor, class_name: 'Armor', optional: true
  has_many :battles, dependent: :destroy
  has_many :item_inventories, dependent: :destroy
  has_many :items, through: :item_inventories

  # Geocoder
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  # Validation
  validates :name, presence: true

  def attack(avatar_id)
    AttackPlayerService.new(self, avatar_id).perform
  end

  def current_battle
    Battle
      .where(avatar1: self)
      .or(Battle.where(avatar2: self))
      .incompleted
      .first
  end

  def apply_effect(action, amount)
    send("apply_#{action}", amount)
  end

  def apply_damage(amount)
    decrement(:hp, amount)
    killed if hp <= 0
    save
  end

  def killed
    current_battle.finish!
    notify_killed
    self.hp = max_hp
    save
  end

  def backpack_full?
    item_inventories.size >= MAX_ITEM_INVENTORY
  end

  def drop_item
    item_inventories.order(created_at: :asc).first.destroy
  end

  private

  # Avoid decode location to address
  def reverse_geocode; end

  def notify_killed
    PlayerChannel.broadcast_to(user, action: 'player:killed')
  end
end
