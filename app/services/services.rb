# frozen_string_literal: true

module Services
  def user_registration
    @user_registration ||= Users::Registration.new
  end
  module_function :user_registration
end
