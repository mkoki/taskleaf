class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order('finished ASC')
    tasks = current_user.tasks.pluck(:title, :time)
    @tasks_title = tasks.map(&:first)
    @tasks_time = tasks.map(&:second)

    respond_to do |format|
      format.html
      format.csv {send_data @tasks.generate_csv, file_name: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"}
    end

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

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
  end

  def start_time
    task = Task.find(params[:id])
    task.update!(start_time: Time.current)
    task.save
  end

  def end_time
    task = Task.find(params[:id])
    task.update!(end_time: Time.current, finished: 1)
    start_time_at = task[:start_time]
    end_time_at = task[:end_time]
    time = end_time_at - start_time_at
    task.update!(time: time)
    task.save
    redirect_to root_path
  end

  def update
    task = Task.find(params[:id])
    task.update!(all_task_params)
    redirect_to root_path
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: 'タスクを追加しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :finished)
  end

  def all_task_params
    params.require(:task).permit(:title, :finished, :content)
  end

end
