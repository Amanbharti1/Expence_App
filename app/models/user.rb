class User < ApplicationRecord
  has_many :expenses
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  
  
  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end  
end
