class ShortUrl < ActiveRecord::Base
	belongs_to :user, dependent:  :destroy
	validates :original_url, :short_url, presence: true
    has_many :short_visits
end
