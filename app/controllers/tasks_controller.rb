class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:index, :new, :edit, :show]
  before_action :authenticate_user, only: [:index, :new, :edit, :show]
  def index
    @tasks = Task.all.order(created_at: "desc")
    if params[:name].present? && params[:state].present?
      @search_params = task_search_params
      @tasks = Task.search(@search_params)
    elsif params[:name].present? 
      @tasks = @tasks.get_by_name(params[:name])
    elsif params[:state].present?
      @tasks = @tasks.get_by_state(params[:state])
    elsif params[:deadline].present?
      @tasks = Task.all.order(deadline: "desc")
    elsif params[:priority].present?
      @tasks = Task.all.order(priority: "desc")
    end
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:name, :content, :state, :deadline, :priority)
  end

  def task_search_params
    params.permit(:name, :state)
  end
end