class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.order(created_at: "desc")
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: t('notice.success')
    else
      flash.now[:alert] = t('flash.failure')
      render :new
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    redirect_to tasks_path, notice: t('notice.update')
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('notice.delete')
  end

  private
  def set_tasks
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :state, :deadline)
  end
end