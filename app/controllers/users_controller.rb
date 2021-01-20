class UsersController < ApplicationController
  before_action :check_current_user, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy, :show, :task_index]

  def new
    if logged_in?
      redirect_to root_path, notice: "ログイン済みのため作成は出来ません"
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "ログインしました"
    else
      render :new, notice: "失敗しました"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit, notice: "失敗しました"
    end
  end

  def show
  end

  def task_index
    @tasks = @user.tasks
  end

  #def favorite
  #  @blog = @user.blogs
  #  favorite = Favorite.where(user_id: current_user.id).pluck(:blog_id)
  #  @favorite_list = Blog.find(favorite)
  #end

  def destroy
    @user.destroy
    redirect_to new_session_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def check_current_user
    user = User.find(params[:id])
    if user.id != session[:user_id]
      redirect_to tasks_path, notice: "この操作はできません"
    end
  end
end