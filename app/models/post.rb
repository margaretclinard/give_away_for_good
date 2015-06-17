class Post < ActiveRecord::Base
  belongs_to :user

  validates :category, :description, presence: true
  #PENDING
  #validates :date_posted, :deadline, presence: true
end
