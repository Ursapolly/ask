class SessionsController < ApplicationController
  def new; end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user.present?
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Добро пожаловать!'
    else
      flash.now.alert = 'Неправильные данные'
      render :new
    end
  end

  def destroy
    delete_session
    redirect_to root_url, notice: 'Вы вышли... Возвращайтесь скорее!'
  end
end