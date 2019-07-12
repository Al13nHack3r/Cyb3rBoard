class User < ApplicationRecord

  # Email Handling Events #
  before_save { email.downcase! }

  # Validate First Name Variables #
  validates :fname, presence: true, length: { maximum: 50 }

  # Validate Last Name Variables #
  validates :lname, presence: true, length: { maximum: 50 }

  # Validate Nick Name Variables #
  validates :nname, presence: true, length: { maximum: 50 }

  # Set Email REGEX Strings #
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Validate Email Variables #
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # Ensure Password Security #
  has_secure_password

  # Validate Password Variables #
  validates :password, presence: true, length: { minimum: 6 }
  
end
