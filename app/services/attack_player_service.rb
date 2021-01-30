# frozen_string_literal: true

class AttackPlayerService
  attr_reader :player, :foe_id

  def initialize(player, foe_id)
    @player = player
    @foe_id = foe_id
  end

  def perform
    return resume_battle if player.current_battle.present?
    return false if foe.blank?
    return false if foe.current_battle.present?

    Battle.create(
      avatar1: player,
      avatar2: foe
    )
  end

  def resume_battle
    player.current_battle.resume
  end

  def foe
    @foe ||=
      Avatar
      .near(player.slice(:latitude, :longitude).values, Avatar::SCAN_RANGE)
      .find(foe_id)
  end
end
