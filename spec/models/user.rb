require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }

    it "requires the presence of an email address" do
      user.email = nil
      expect(user).not_to be_valid
    end

    it "requires the presence of a password" do
      user.password = nil
      expect(user).not_to be_valid
    end
  end
end
