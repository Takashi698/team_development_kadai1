class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :destroy]
  skip_before_action :login_required, only: [:new, :create]
  before_action :ensure_current_user, only: [:edit, :update, :destroy]

  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show

  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_current_user
    if current_user.id != @user.id
      redirect_to user_path(current_user.id), warning: "権限がありません"
    end
  end
end
