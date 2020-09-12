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

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice: 'Task is create'
    else
      flash.now[:error] = 'save failure'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end