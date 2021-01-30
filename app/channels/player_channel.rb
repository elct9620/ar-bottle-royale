# frozen_string_literal: true

class PlayerChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def load_avatar
    PlayerChannel.broadcast_to(current_user, action: 'avatar:load', payload: { avatar: current_user.avatar })
  end

  def join_battle
    current_user.avatar.current_battle.join!
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
