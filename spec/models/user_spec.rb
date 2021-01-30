# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'prepare avatar' do
    subject(:save_user) { user.save }

    let(:user) { build(:user) }

    it { expect { save_user }.to change(Avatar.all, :size).by(1) }

    context 'when update exists user' do
      let(:user) { create(:user) }

      before { user.email = Faker::Internet.email }

      it { expect { save_user }.not_to change(Avatar.all, :size) }
    end

    context 'when update exists user without avatar' do
      let(:user) { create(:user) }

      before do
        user.avatar.destroy
        user.reload
      end

      it { expect { save_user }.to change(Avatar.all, :size).by(1) }
    end
  end
end
