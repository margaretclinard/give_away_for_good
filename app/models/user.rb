class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :posts, foreign_key: :user_id

  validates :email, :name, presence: true
  validates :name, length: { minimum: 3 }
  validates :email, format: { with: /.+@.+\..+/, message: "must be an email address" }, uniqueness: true
  validates :password, confirmation: true
  validates :password, :password_confirmation, presence: { on: :create }
  validates :company, presence: true
  validates :street1, presence: true
  validates :street2, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

end