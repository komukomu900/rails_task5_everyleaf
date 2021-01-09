class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: "登録しました"
    else
      flash.now[:alert] = "失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to tasks_path, notice: "更新しました"
  end

  def destroy
    @task.destroy
    redirect_to blogs_path, notice: "削除しました"
  end

  private
  def set_tasks
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :state, :deadline)
  end
end