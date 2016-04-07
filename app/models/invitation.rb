class Invitation <ActiveRecord::Base
 before_create :generate_token
 belongs_to :inviter, class_name: "User"

 validates :recipient_name, presence: true 
 validates :recipient_email, presence: true
 validates :message, presence: true 

private
 def generate_token
    self.token = SecureRandom.urlsafe_base64
  end

end 