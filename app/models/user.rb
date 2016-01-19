class User <ActiveRecord::Base
  
  has_many :reviews
  has_many :queue_items, -> {order :position}
  has_secure_password validations: false
  validates :email, presence: true 
  validates :password, presence: true 
  validates :full_name, presence: true 
  
  validates_uniqueness_of :email
end 