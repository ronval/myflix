class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  validates :review_content, presence: true 
  #validates :review_content, presence: true 
  validates_presence_of :score
end 