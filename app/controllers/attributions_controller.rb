class AttributionsController < ApplicationController
  before_action :set_attribution, only: [:show, :update, :destroy]

  # GET /attributions
  def index
    @attributions = Attribution.all

    render json: @attributions
  end

  # GET /attributions/1
  def show
    render json: @attribution
  end

  # POST /attributions
  def create
    @attribution = Attribution.new(attribution_params)

    if @attribution.save
      render json: @attribution, status: :created, location: @attribution
    else
      render json: @attribution.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attributions/1
  def update
    if @attribution.update(attribution_params)
      render json: @attribution
    else
      render json: @attribution.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attributions/1
  def destroy
    @attribution.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attribution
      @attribution = Attribution.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attribution_params
      params.require(:attribution).permit(:name, :quote_id)
    end
end
