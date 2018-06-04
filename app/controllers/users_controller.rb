class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже вошли!' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже вошли!' if current_user.present?
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: 'Регистрация прошла успешно!'
    else
      render 'new'
    end
  end

  def edit;
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Профиль отредактирован!'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    if @user.delete && @user == current_user
      @user.destroy
      delete_session
      redirect_to root_url, notice: 'Профиль удалён!'
    end
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :header_color)
  end
end
