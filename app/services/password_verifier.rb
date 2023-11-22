# frozen_string_literal: true

# class for verifying password strength based on given set of rules
class PasswordVerifier
  attr_accessor :user, :password

  RULES = [
    { text: 'Has more than 8 characters', verify: ->(pwd) { pwd ? pwd.size > 8 : false} },
    { text: 'Has at least one downcase letter', verify: ->(pwd) { pwd ? pwd.match(/[a-z]/).present? : false} },
    { text: 'Has at least one uppercase letter', verify: ->(pwd) { pwd ? pwd.match(/[A-Z]/).present? : false} },
    { text: 'Has at least one number', verify: ->(pwd) { pwd ? pwd.match(/[0-9]/).present? : false} },
    { text: 'Has at least one special character',
      verify: ->(pwd) { pwd ? pwd.match(/(?=.*?[_!#@$?])/).present? : false } }
  ].freeze

  def initialize(user)
    @user = user
    @password = user.password_digest
  end

  def rules_statuses
    @rules_statuses ||= RULES.collect do |rule|
      { text: rule[:text], missing: !rule[:verify].call(password) }
    end
  end

  def password_strength
    (rules_statuses.reject { |rule| rule[:missing] }.size.to_f / rules_statuses.size) * 100
  end
end
