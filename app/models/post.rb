class Post < ActiveRecord::Base
  belongs_to :user

  validates :category, :description, :deadline, presence: true

end
