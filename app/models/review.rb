class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates :review_content, presence: true 
end 