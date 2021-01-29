# frozen_string_literal: true

class WorldMapChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'WorldMap'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
