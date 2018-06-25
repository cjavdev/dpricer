class FetchListingsJob < ApplicationJob
  queue_as :high

  def perform(query_params={})
    query_params[:section_offset] ||= 0
    listings = AirbnbClient.new.listings(query_params)
    old_count = Listing.count
    listings.each do |listing_data|
      find_or_create_listing(listing_data)
    end
    new_count = Listing.count - old_count
    puts "#{ new_count } New Listings created."
    return if new_count == 0
    query_params[:section_offset] = query_params[:section_offset].to_i + 1
    return if query_params[:section_offset] > 20
    FetchListingsJob.perform_later(query_params)
  end

  def find_or_create_listing(data)
    Listing.from_data(data)
  end
end
