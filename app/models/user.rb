class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token

  # Email Handling Events #
  before_save { email.downcase! }

  # Validate First Name Variables #
  validates :fname, presence: true, length: { maximum: 50 }

  # Validate Last Name Variables #
  validates :lname, presence: true, length: { maximum: 50 }

  # Validate Nick Name Variables #
  validates :nname, presence: true, length: { maximum: 50 }

  # Validate Bio Variables #
  validates :bio, presence: true, length: { maximum: 500 }, allow_nil: true

  # Validate Web Variables #
  validates :web, presence: true, length: { maximum: 30 }, allow_nil: true

  # Validate Discord Variables #
  validates :discord, presence: true, length: { maximum: 50 }, allow_nil: true

  # Validate Github Variables #
  validates :github, presence: true, length: { maximum: 75 }, allow_nil: true

  # Set Email REGEX Strings #
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Validate Email Variables #
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # Ensure Password Security #
  has_secure_password

  # Validate Password Variables #
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def feed
    Micropost.where("user_id = ?", id)
  end
end
