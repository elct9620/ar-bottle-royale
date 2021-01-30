# frozen_string_literal: true

class NearbyPlayerRefreshService
  attr_reader :avatar

  def initialize(avatar)
    @avatar = avatar
  end

  def perform
    nearby_players.each do |player|
      PlayerChannel.broadcast_to(player, avatar: avatar)
    end
  end

  def nearby_players
    # Nearby 1km
    Avatar
      .includes(:user)
      .near(avatar.slice(:latitude, :longitude).values, 1)
      .map(&:user)
  end
end
