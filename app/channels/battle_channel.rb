# frozen_string_literal: true

class BattleChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def attack
    BattleAttackService.new(current_user.avatar).perform
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
