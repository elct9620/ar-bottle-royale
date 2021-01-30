# frozen_string_literal: true

class BattleChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def attack
    # TODO
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
