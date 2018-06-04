class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def delete_session
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: 'Упс! Сюда нельзя ;)'
  end
end