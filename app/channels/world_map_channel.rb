# frozen_string_literal: true

class WorldMapChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'WorldMap'
  end

  def update_position(data)
    current_user.avatar.update(data['position'])
    NearbyPlayerRefreshService.new(current_user.avatar).perform
  end

  def attack(data)
    current_user.avatar.attack(data['avatar_id'])
  end

  def collect(data)
    CollectItemService.new(current_user.avatar, data['items']).perform
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
