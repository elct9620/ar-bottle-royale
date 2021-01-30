# frozen_string_literal: true

class Potion < Item
  def apply(avatar)
    avatar.with_lock do
      avatar.increment(:hp, value).save
    end
  end
end
