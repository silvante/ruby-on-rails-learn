class MultitudesController < ApplicationController
  before_action :set_multitude, only: %i[ show edit update destroy ]

  # GET /multitudes or /multitudes.json
  def index
    @multitudes = Multitude.all
  end

  # GET /multitudes/1 or /multitudes/1.json
  def show
  end

  # GET /multitudes/new
  def new
    @multitude = Multitude.new
  end

  # GET /multitudes/1/edit
  def edit
  end

  # POST /multitudes or /multitudes.json
  def create
    @multitude = Multitude.new(multitude_params)

    respond_to do |format|
      if @multitude.save
        format.html { redirect_to @multitude, notice: "Multitude was successfully created." }
        format.json { render :show, status: :created, location: @multitude }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @multitude.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /multitudes/1 or /multitudes/1.json
  def update
    respond_to do |format|
      if @multitude.update(multitude_params)
        format.html { redirect_to @multitude, notice: "Multitude was successfully updated." }
        format.json { render :show, status: :ok, location: @multitude }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @multitude.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /multitudes/1 or /multitudes/1.json
  def destroy
    @multitude.destroy!

    respond_to do |format|
      format.html { redirect_to multitudes_path, status: :see_other, notice: "Multitude was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_multitude
      @multitude = Multitude.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def multitude_params
      params.require(:multitude).permit(:title, :description, :banner, :icon)
    end
end
