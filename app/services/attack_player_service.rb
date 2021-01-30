# frozen_string_literal: true

class AttackPlayerService
  attr_reader :player, :foe_id

  def initialize(player, foe_id)
    @player = player
    @foe_id = foe_id
  end

  def perform
    return false if foe.blank?

    Battle.create(
      avatar1: player,
      avatar2: foe
    )
  end

  def foe
    @foe ||=
      Avatar
      .near(player.slice(:latitude, :longitude).values, Avatar::SCAN_RANGE)
      .find(foe_id)
  end
end
