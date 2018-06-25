# == Schema Information
#
# Table name: listing_days
#
#  id         :integer          not null, primary key
#  listing_id :integer          not null
#  price      :integer          not null
#  price_on   :date             not null
#  blocked    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_listing_days_on_listing_id  (listing_id)
#

class ListingDay < ApplicationRecord
  belongs_to :listing
  validates :price_on, :price, :listing, presence: true
end
