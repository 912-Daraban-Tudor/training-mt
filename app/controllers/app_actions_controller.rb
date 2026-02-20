class AppActionsController < ApplicationController
  before_action :set_app_action, only: %i[ show edit update destroy ]

  # GET /app_actions or /app_actions.json
  def index
    @app_actions = AppAction.all
  end

  # GET /app_actions/1 or /app_actions/1.json
  def show
  end

  # GET /app_actions/new
  def new
    @app_action = AppAction.new
  end

  # GET /app_actions/1/edit
  def edit
  end

  # POST /app_actions or /app_actions.json
  def create
    @app_action = AppAction.new(app_action_params)

    respond_to do |format|
      if @app_action.save
        format.html { redirect_to @app_action, notice: "App action was successfully created." }
        format.json { render :show, status: :created, location: @app_action }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @app_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_actions/1 or /app_actions/1.json
  def update
    respond_to do |format|
      if @app_action.update(app_action_params)
        format.html { redirect_to @app_action, notice: "App action was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @app_action }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @app_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_actions/1 or /app_actions/1.json
  def destroy
    @app_action.destroy!

    respond_to do |format|
      format.html { redirect_to app_actions_path, notice: "App action was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app_action
      @app_action = AppAction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def app_action_params
      params.require(:app_action).permit(:name)
    end
end
