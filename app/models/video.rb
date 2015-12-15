class Video < ActiveRecord::Base
  belongs_to :category
  validates :title
  validates :description
end 