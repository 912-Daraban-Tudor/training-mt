class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]

  # GET /boards or /boards.json
  def index
    @boards = Board.active.includes(:user)
  end

  # GET /boards/1 or /boards/1.json
  def show
    @ordered_columns = @board.columns.order("board_columns.column_position ASC")
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = Board.new(board_params)
    @board.user = User.find(board_params[:user_id]) || User.create!(name: "autocreated", email: "auto@creat.ed")

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
    respond_to do |format|

      if @board.update(board_params)

        if @board.saved_change_to_archived? && @board.archived == true
          ArchiveBoardJob.perform_async(@board.id)
          format.html { redirect_to @boards, notice: "Board was successfully archived.", status: :see_other }
          format.json { head :no_content }
        else
        format.html { redirect_to @board, notice: "Board was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @board }
        end

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
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
