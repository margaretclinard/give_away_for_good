class Post < ActiveRecord::Base
  belongs_to :user

  validates :category, :description, :date_posted, :deadline, presence: true
end
