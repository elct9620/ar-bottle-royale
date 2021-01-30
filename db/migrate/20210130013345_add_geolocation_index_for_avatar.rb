# frozen_string_literal: true

class AddGeolocationIndexForAvatar < ActiveRecord::Migration[6.1]
  def change
    add_index :avatars, %i[latitude longitude], name: :location
  end
end
