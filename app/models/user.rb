class User <ActiveRecord::Base
  
  has_many :reviews, -> {order "created_at DESC"}
  has_many :queue_items, -> {order :position}
  
has_many :following_relationships, class_name:"Relationship", foreign_key: :follower_id


  

  # has_many :relationships
  # has_many :leaders, :through => :relationships
  # has_many :followers, class_name:"Relationship", :foreign_key => 'leader_id'
  # has_many :inverse_leaders, :through => :followers, source: :user

 


  has_secure_password validations: false
  validates :email, presence: true 
  validates :password, presence: true 
  validates :full_name, presence: true 
  
  validates_uniqueness_of :email




  def queued_video?(video)
    queue_items.map(&:video).include?(video)
     
  end
end 