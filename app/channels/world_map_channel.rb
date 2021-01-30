# frozen_string_literal: true

class WorldMapChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'WorldMap'
  end

  def update_position(data)
    current_user.avatar.update(data['position'])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
