class Restaurant < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :state_provence, presence: true
  validates :postalcode, presence: true

  has_many :reviews
  belongs_to :category
end
