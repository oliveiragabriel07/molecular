class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_or_initialize_by(email: "user@email.com")
  end

  # TODO: add to readme
  # def molecular_owner
  #   User.find_or_initialize_by(email: "user=saddssdds@email.com")
  # end
end
