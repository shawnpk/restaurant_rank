class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user

  validates :comment, presence: true
end
