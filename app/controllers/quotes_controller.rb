require "uri"
require 'net/http'
require 'net/https'

# post request to trigger front end builds
def post_netlify_webhook
    uri = URI.parse("https://api.netlify.com/build_hooks/5c8a5ae08e0d9701e58d93ef")
    uri.query = URI.encode_www_form({})
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)
    http.request(request).body
end

class QuotesController < OpenReadController
  before_action :set_quote, only: [:show, :update, :destroy]

  # GET /quotes
  def index
    @quotes = Quote.all
    render json: @quotes
  end

  # GET /quotes/1
  def show
    render json: @quote
  end

  # POST /quotes
  def create
    @quote = current_user.quotes.create(quote_params)

    if @quote.save
      render json: @quote, status: :created, location: @quote
      # trigger front end build with new data
      post_netlify_webhook if Rails.env.production?
    else
      render json: @quote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quotes/1
  def update
    if @quote.update(quote_params)
      render json: @quote
      # trigger front end build with new data
      post_netlify_webhook if Rails.env.production?
    else
      render json: @quote.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quotes/1
  def destroy
    @quote.destroy
    # trigger front end build with new data
    post_netlify_webhook if Rails.env.production?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = current_user.quotes.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def quote_params
      params.require(:quote).permit(:body, :attribution)
    end
end
