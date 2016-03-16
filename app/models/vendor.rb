class Vendor < ActiveRecord::Base
  attr_accessor :remember_token
	before_save { self.email = email.downcase }
	validates :username,  presence: true, length: { maximum: 50 }
	validates :company,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "phone number must be XXX-XXX-XXXX" }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :website, format: { with: /\Ahttps?:\/\/.*\z/,
                      message: "must start with http:// or https://" }, allow_nil: true
  has_many :reviews
  mount_uploader :image, ImageUploader
  mount_uploader :menu1, Menu1Uploader
  mount_uploader :menu2, Menu2Uploader
  validates :sun_open, presence: true, allow_nil: true
  validates :mon_open, presence: true, allow_nil: true
  validates :tues_open, presence: true, allow_nil: true
  
  #acts_as_gmappable, :process_geocoding => false


  geocoded_by :ip_address
  #after_validation :geocode,
  #                    :if => lambda{ |obj| obj.address_changed? }

  # Returns the hash digest of the given string.
  def Vendor.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Vendor.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def vendor_remember
    self.remember_token = Vendor.new_token
    update_attribute(:remember_digest, Vendor.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def vendor_authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def vendor_forget
    update_attribute(:remember_digest, nil)
  end
end
