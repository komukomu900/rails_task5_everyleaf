class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :update, :destroy, :change_admin]

  def index
    @users = User.includes(:tasks).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "削除しました"
    else
      redirect_to admin_users_path, notice: "管理者は1人以上必要です"
    end
  end

  def change_admin
    if @user.admin == true
      @user.admin = false
      if @user.save
        redirect_to admin_users_path, notice: "権限を削除しました"
      else
        redirect_to admin_users_path, notice: "管理者は1人以上必要です"
      end
    else
      @user.admin = true
      @user.save
      redirect_to admin_users_path, notice: "権限を付与しました"
    end
  end

  private
  def admin_user
    redirect_to root_path, notice: "あなたにはこの操作を行う権限がありません" unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end