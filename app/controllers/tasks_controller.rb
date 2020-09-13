class TasksController < ApplicationController

  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

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

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task is update'
    else
      flash.now[:error] = 'update failure'
      render :edit
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    redirect_to root_path, notice: 'succes delete'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline)
  end
end