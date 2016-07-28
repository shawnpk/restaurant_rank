class Restaurant < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :city, presence: true
  validates :state_provence, presence: true

  has_many :reviews
  belongs_to :category

  geocoded_by :full_address
  after_validation :geocode

  mount_uploader :image, ImageUploader

  # def full_address
  #   [address1, address2, city, state_provence, postalcode].join(', ')
  # end

  def full_address
    [city, state_provence].join(', ')
  end

  def self.search(params)
    restaurants = Restaurant.where(category_id: params[:category].to_i)

    restaurants = restaurants.where("name like ? or description like ?",
    "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?

    restaurants = restaurants.near(params[:location], 25) if params[:location].present?

    restaurants
  end
end
