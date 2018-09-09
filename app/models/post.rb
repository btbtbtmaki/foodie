class Post < ApplicationRecord
  def to_param
    code
  end

  belongs_to :user

  mount_uploaders :image, ImageUploader
  #validates_integrity_of :image
  #validates :user_id, presence: true
  #attr_accessible :address, :latitude, :longitude
  validates :address, presence:true
  geocoded_by :address
  after_validation :geocode
  has_one :restaurant
  default_scope -> { order(created_at: :desc) } 

end
