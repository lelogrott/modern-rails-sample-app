# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordVerifier do
  let(:verifier) { described_class.new(user) }
  let(:user) { create(:user, password:) }
  let(:password) { 'g00dPassword!' }

  describe 'validates rules' do
    it 'checks all rules' do
      expect(verifier.rules_statuses.any? { |rule| rule[:missing] }).to be_falsey
    end

    context 'length validation' do
      let(:password) { 'g00dPas!' }

      it 'fails length validation' do
        missing_rules = verifier.rules_statuses.select { |rule| rule[:missing] }
        expect(missing_rules.size).to eql(1)
        expect(missing_rules.first[:text]).to eql('Has more than 8 characters')
      end

      it 'passes length validation' do
        user.password = 'g00dPass!'
        expect(verifier.rules_statuses.any? { |rule| rule[:missing] }).to be_falsey
      end
    end

    context 'downcase validation' do
      let(:password) { 'G00DPASS!' }

      it 'fails downcase validation' do
        missing_rules = verifier.rules_statuses.select { |rule| rule[:missing] }
        expect(missing_rules.size).to eql(1)
        expect(missing_rules.first[:text]).to eql('Has at least one downcase letter')
      end

      it 'passes downcase validation' do
        user.password = 'g00dPass!'
        expect(verifier.rules_statuses.any? { |rule| rule[:missing] }).to be_falsey
      end
    end

    context 'uppercase validation' do
      let(:password) { 'g00dpass!' }

      it 'fails uppercase validation' do
        missing_rules = verifier.rules_statuses.select { |rule| rule[:missing] }
        expect(missing_rules.size).to eql(1)
        expect(missing_rules.first[:text]).to eql('Has at least one uppercase letter')
      end

      it 'passes uppercase validation' do
        user.password = 'g00dPass!'
        expect(verifier.rules_statuses.any? { |rule| rule[:missing] }).to be_falsey
      end
    end

    context 'number validation' do
      let(:password) { 'goodPass!' }

      it 'fails number validation' do
        missing_rules = verifier.rules_statuses.select { |rule| rule[:missing] }
        expect(missing_rules.size).to eql(1)
        expect(missing_rules.first[:text]).to eql('Has at least one number')
      end

      it 'passes number validation' do
        user.password = 'g00dPass!'
        expect(verifier.rules_statuses.any? { |rule| rule[:missing] }).to be_falsey
      end
    end

    context 'special character validation' do
      let(:password) { 'g00dPass1' }

      it 'fails special character validation' do
        missing_rules = verifier.rules_statuses.select { |rule| rule[:missing] }
        expect(missing_rules.size).to eql(1)
        expect(missing_rules.first[:text]).to eql('Has at least one special character')
      end

      it 'passes special character validation' do
        user.password = 'g00dPass!'
        expect(verifier.rules_statuses.any? { |rule| rule[:missing] }).to be_falsey
      end
    end
  end
end
