# frozen_string_literal: true

class NearbyPlayerRefreshService
  attr_reader :avatar

  def initialize(avatar)
    @avatar = avatar
  end

  def perform
    nearby_players.each do |player|
      PlayerChannel.broadcast_to(player,
                                 action: 'player:refresh',
                                 payload: { avatar: avatar, id: avatar.id })
    end
  end

  def nearby_players
    # Nearby 1km
    Avatar
      .includes(:user)
      .near(avatar.slice(:latitude, :longitude).values, Avatar::SCAN_RANGE)
      .map(&:user)
  end
end
