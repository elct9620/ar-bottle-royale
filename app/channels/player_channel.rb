# frozen_string_literal: true

class PlayerChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def load_avatar
    PlayerChannel.broadcast_to(current_user, action: 'avatar:load', payload: { avatar: current_user.avatar })
  end

  def load_inventories
    PlayerChannel
      .broadcast_to(
        current_user,
        action: 'inventory:changed',
        payload: {
          inventories: current_user.avatar
            .item_inventories.includes(:item).as_json(include: :item)
        }
      )
  end

  def use_item(data)
    current_user
      .avatar
      .item_inventories
      .find_by(id: data['inventory_id'])
      &.use
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
