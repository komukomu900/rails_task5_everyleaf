class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:index, :new, :edit, :show]
  before_action :authenticate_user, only: [:index, :new, :edit, :show]
  def index
    @tasks = current_user.tasks
    case
    when params[:title].present?, params[:status].present?, params[:label_id].present?
      @tasks = @tasks.label_is(params[:label_id]).get_by_title(params[:title]).get_by_state(params[:state])
    when params[:deadline].present?
      @tasks = Task.all.order(deadline: "desc")
    when params[:priority].present?
      @tasks = Task.all.order(priority: "desc")
    else
      @tasks = @tasks.all.order(created_at: "desc")
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
    params.require(:task).permit(:title, :content, :state, :deadline, :priority,  { label_ids: [] })
  end

  def task_search_params
    params.permit(:title, :state)
  end
end