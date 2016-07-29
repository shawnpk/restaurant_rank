class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    [city, state_provence].join(', ')
  end
end
