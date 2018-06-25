require 'rest-client'
require "addressable/uri"

class AirbnbClient
  def client_id
    ENV['AIRBNB_CLIENT_ID']
  end

  def key
    ENV['AIRBNB_KEY']
  end

  def login(username, password)
    data = {
        username: username,
        password: password,
        prevent_account_creation: 'true'
    }
    headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-Airbnb-API-Key': client_id
    }
    result = post('/v1/authorize', {client_id: client_id}, data, headers)
    result
  end

  def events(listing_id, query_params={})
    query_params[:key] = key
    query_params[:currency] = 'USD'
    query_params[:locale] = 'en'
    query_params[:listing_id] = listing_id
    from_date = Date.today - 2.months
    query_params[:month] = from_date.month
    query_params[:year] = from_date.year
    query_params[:count] = 12
    query_params[:_format] = 'with_conditions'
    result = get("/v2/calendar_months", query_params)
    days = {}
    result["calendar_months"].each do |month|
      month["days"].each do |day|
        days[day["date"]] = {
          available: day["available"],
          price: day["price"]["native_price"],
          date: day["date"]
        }
      end
    end
    days
  end

  def listings_for_host(host_id, query_params={})
    query_params[:user_id] = host_id
    query_params[:_limit] ||= 20
    query_params[:_offset] ||= 0
    query_params[:_format] = 'v1_legacy_long'
    query_params[:has_availability] = false
    result = get("/v2/listings", query_params)
    result["listings"]
  end

  def listings(query_params={})
    # query_params[:_format] = 'for_search_results_with_minimal_pricing'
    query_params[:key] = key
    result = get("/v2/explore_tabs", query_params)
    result["explore_tabs"][0]["sections"][0]["listings"].map {|r| r["listing"]}
  end

  def host(host_id, query_params={})
    query_params[:_format] = 'with_content_framework_articles'
    result = get("/v2/users/#{ host_id }", query_params)
    result["user"]
  end

  def construct_url(path, query_params)
    query_params[:client_id] = client_id
    Addressable::URI.new(
      :scheme => 'https',
      :host => 'api.airbnb.com',
      :path => path,
      :query_values => query_params,
    ).to_s
  end

  def get(path, query_params)
    url = construct_url(path, query_params)
    puts "Getting #{ url } with #{ query_params }"
    result = RestClient.get(url)
    if result.code == 200
      JSON.parse(result.body)
    end
  end

  def post(path, query_params, payload, headers)
    url = construct_url(path, query_params)
    puts "Posting #{ url } with #{ payload }"
    result = RestClient.post(url, payload, headers)
    if result.code == 200
      JSON.parse(result.body)
    end
  end
end
