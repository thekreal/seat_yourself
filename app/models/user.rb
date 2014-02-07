class User < ActiveRecord::Base

  # Bcrypt Password Digest Encryption
  has_secure_password

  has_many :reservations
  has_many :reserved_restaurants, through: :reservations, source: "restaurant"

  #  Callbacks and Validations
  before_save { email.downcase! }
  before_create :generate_token

  validates :name,      presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,     presence: true,
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: {
                          case_sensitive: false,
                          message: "has already being registered"
                        }

  validates :password,  length: { in: 6..32 },
                        confirmation: true,
                        exclusion: {
                          in: lambda { |user| [user.email] },
                          message: "can not be the same as email"
                        },
                        unless: :updating_account

  after_validation { self.errors.messages.delete(:password_digest) }

  # Scopes
  default_scope { order(created_at: :desc) }

  # Retrieve Gravatar from gravatar.com using user email
  def gravatar(size = 50)
    return "https://secure.gravatar.com/avatar/#{Digest::MD5::hexdigest(email)}?s=#{size}"
  end

  # Class Method: Generate New Token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Class Method: Encrypt Token
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

private

  # Generate and set user token before create
  def generate_token
    self.token = User.encrypt(User.new_token)
  end

  # Check if password_digest exist, use for update account
  def updating_account
    !password_digest.blank?
  end

end
