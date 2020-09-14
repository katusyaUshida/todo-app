class TasksController < ApplicationController
  
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

  def index
    @task = Task.all
    # boards = Board.find(params[:board_id])
    # @tasks = boards.tasks.all
  end

  def show
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
    
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params.merge!(user_id: current_user.id))
    if @task.save
      redirect_to board_path(board), notice: 'Task is create'
    else
      flash.now[:error] = 'save failure'
      render :new
    end
  end

  def edit
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
  end

  def update
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:id])
    if @task.update(task_params)
      #binding.pry
      redirect_to board_task_path(@board, @task), notice: 'Task is update'
    else
      flash.now[:error] = 'update failure'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])
    task.destroy!
    redirect_to root_path, notice: 'succes delete'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :eyecatch)
  end

  
end