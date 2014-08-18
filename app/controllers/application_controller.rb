class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'trendy', password: 'trends', if: :http_basic?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  private
  def http_basic?
    true
  end
end
