class Restaurant < ApplicationRecord
  belongs_to :post
  #validates :post_id, presence:true
  #validates :address, presence:true
  validates :name, presence:true

  #attr_accessible

end
