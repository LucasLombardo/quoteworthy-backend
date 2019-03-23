require 'uri'
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
    # find attribution if it exists
    attribution = Attribution.find_by(name: quote_params[:attribution])
    # if attribution does not exist, create it
    if attribution.nil?
      attribution = Attribution.create(name: quote_params[:attribution])
    end
    # create quote with the attribution
    @quote = current_user.quotes.create(
      body: quote_params[:body],
      attribution: attribution
    )

    # render results and trigger build hook
    if @quote.save
      render json: @quote, status: :created, location: @quote
      # trigger front end build with new data
      Thread.new do
        post_netlify_webhook if Rails.env.production?
      end
    else
      render json: @quote.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /quotes/1
  def update
    # find attribution if it exists
    attribution = Attribution.find_by(name: quote_params[:attribution])
    # if attribution does not exist, create it
    if attribution.nil?
      attribution = Attribution.create(name: quote_params[:attribution])
    end

    # set previous attribution
    previous_attribution = Quote.find(params[:id]).attribution

    # update quote with new params
    if @quote.update(body: quote_params[:body], attribution: attribution)
      render json: @quote

      # if attribution changed and previous will now have 0 quotes, delete previous
      if previous_attribution[:name] != quote_params[:attribution]
        previous_attribution.destroy if previous_attribution.quotes.length < 1
      end

      # trigger front end build with new data
      Thread.new do
        post_netlify_webhook if Rails.env.production?
      end
    else
      render json: @quote.errors, status: :unprocessable_entity
    end
  end

  # DELETE /quotes/1
  def destroy
    # current attribution
    previous_attribution = Quote.find(params[:id]).attribution
    @quote.destroy
      # if attribution will now have 0 quotes, delete it
      previous_attribution.destroy if previous_attribution.quotes.length < 1
      # trigger front end build with new data
      Thread.new do
        post_netlify_webhook if Rails.env.production?
      end
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
