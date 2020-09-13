class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, notice: 'Board is create'
    else
      flash.now[:error] = 'save failure'
      render :new
    end
  end

  def update
    @board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to boards_path, notice: 'Board is update'
    else
      flash.now[:error] = 'update failure'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy!
    redirect_to root_path, notice: 'succes delete'
  end

  private
  def board_params
    params.require(:board).permit(:title, :content)
  end
end