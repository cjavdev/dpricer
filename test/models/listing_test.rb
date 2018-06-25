# == Schema Information
#
# Table name: listings
#
#  id           :integer          not null, primary key
#  headline     :string
#  description  :string
#  photo_url    :string
#  channel_id   :integer
#  external_id  :integer
#  accommodates :integer
#  bedrooms     :integer
#  bathrooms    :integer
#  beds         :integer
#  lat          :float
#  lng          :float
#  city         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_listings_on_accommodates  (accommodates)
#  index_listings_on_bedrooms      (bedrooms)
#  index_listings_on_channel_id    (channel_id)
#  index_listings_on_external_id   (external_id)
#

require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
