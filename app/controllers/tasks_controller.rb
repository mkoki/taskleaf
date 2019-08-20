class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to root_path
  end

  def start_time
    task = Task.find(params[:id])
    task.update!(start_time: Time.now)
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :finished)
  end

end
