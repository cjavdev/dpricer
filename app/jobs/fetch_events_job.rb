class FetchEventsJob < ApplicationJob
  queue_as :low

  def perform(listing_id)
    puts "Fetching events -> #{ listing_id }"
    listing = Listing.find(listing_id)
    if !listing.calendar_data.nil?
      puts "Skipping fetching events for listing with id #{ listing_id }"
      return
    end
    days = AirbnbClient.new.events(listing.external_id)
    create_or_update_days(listing, days)
  end

  def create_or_update_days(listing, days)
    days.each do |day|
      listing.days
    end
  end
end
