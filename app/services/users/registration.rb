# frozen_string_literal: true

module Users
  class Registration
    class UserCreationError < StandardError; end

    def sign_up(user_attrs:)
      create_user(user_attrs).tap do |user|
        send_confirmation_email(user)
      end
    end

    private

    def create_user(user_attrs)
      # TODO: hack to be removed when migration to devise is complete
      user_attrs[:password_confirmation] = user_attrs[:password]
      user = User.create!(user_attrs)
      raise UserCreationError.new unless user.persisted?

      user
    end

    def send_confirmation_email(user)
      UserNotifierMailer.send_signup_email(user).deliver
    end
  end
end
