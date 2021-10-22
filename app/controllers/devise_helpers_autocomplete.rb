class ApplicationController < ActionController::Base
  # @return [User]
  def current_user
    super
  end

  def authenticate_user!
    super
  end

  # @return [Boolean]
  def user_signed_in?
    super
  end

  # @return [Hash]
  def user_session
    super
  end
end
