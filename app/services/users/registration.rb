# frozen_string_literal: true

module Users
  class Registration
    class UserCreationError < StandardError; end

    def sign_up(user:)
      create_user(user)
      send_confirmation_email(user)
      user
    end

    private

    def create_user(user)
      user.save
      raise UserCreationError.new unless user.persisted?
    end

    def send_confirmation_email(user)
      UserNotifierMailer.send_signup_email(user).deliver
    end
  end
end
