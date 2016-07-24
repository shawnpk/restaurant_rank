class Restaurant < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :city, presence: true
  validates :state_provence, presence: true

  has_many :reviews
  belongs_to :category

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [address1, address2, city, state_provence, postalcode].join(', ')
  end
end
