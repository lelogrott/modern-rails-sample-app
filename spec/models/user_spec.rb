# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }

    context 'email address validation' do
      it 'requires the presence of an email address' do
        user.email = nil
        expect(user).not_to be_valid
      end

      it 'requires a valid email address' do
        user.email = 'invalid_email.com'
        expect(user).not_to be_valid
      end
    end

    it 'requires the presence of a password' do
      user.password = nil
      expect(user).not_to be_valid
    end
  end
end
