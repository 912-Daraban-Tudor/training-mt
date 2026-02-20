class BoardsController < ApplicationController
  include BoardsHelper
  before_action :set_board, only: %i[ show edit update destroy ]

  # GET /boards or /boards.json
  def index
    @boards = Board.active.includes(:user)
    authorize Board
  end

  # GET /boards/1 or /boards/1.json
  def show
    authorize @board
    @ordered_columns = @board.columns.order("board_columns.column_position ASC")
  end

  # GET /boards/new
  def new
    @board = Board.new
    authorize @board
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = Board.new(board_params)
    authorize @board
    @board.user = current_user

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    authorize @board

    if params[:reorder].present?
      column_id = params.dig(:reorder, :column_id)
      target_position = params.dig(:reorder, :target_position)

      reorder_board_columns(column_id, target_position)
    end


    respond_to do |format|

      if @board.update(board_params)
        #
        # if @board.saved_change_to_archived? && @board.archived == true
        #   ArchiveBoardJob.perform_async(@board.id)
        #   format.html { redirect_to @boards, notice: "Board was successfully archived.", status: :see_other }
        #   format.json { head :no_content }
        # else
        format.html { redirect_to @board, notice: "Board was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @board }
        # end

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    authorize @board
    @board.destroy!

    respond_to do |format|
      format.html { redirect_to boards_path, notice: "Board was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:name, :user_id, :archived, column_ids: [] )
    end
end
