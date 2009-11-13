require 'digest/sha1'


class User < ActiveRecord::Base

  has_many :topics
  has_many :posts
  has_many :messages
  has_one :player, :dependent => :destroy
  
  before_create :generate_token
  after_create :add_player
  
  EmailAddress = begin
    qtext = '[^\\x0d\\x22\\x5c\\x80-\\xff]'
    dtext = '[^\\x0d\\x5b-\\x5d\\x80-\\xff]'
    atom = '[^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-' +
      '\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+'
    quoted_pair = '\\x5c[\\x00-\\x7f]'
    domain_literal = "\\x5b(?:#{dtext}|#{quoted_pair})*\\x5d"
    quoted_string = "\\x22(?:#{qtext}|#{quoted_pair})*\\x22"
    domain_ref = atom
    sub_domain = "(?:#{domain_ref}|#{domain_literal})"
    word = "(?:#{atom}|#{quoted_string})"
    domain = "#{sub_domain}(?:\\x2e#{sub_domain})*"
    local_part = "#{word}(?:\\x2e#{word})*"
    addr_spec = "#{local_part}\\x40#{domain}"
    pattern = /\A#{addr_spec}\z/
  end
  
  ::MINIMUM_PASSWORD_LENGTH = 6
  
  validates_presence_of     :lastname, :firstname
  validates_uniqueness_of   :login
  validates_format_of       :email, :with => EmailAddress, :allow_blank => true
  validates_confirmation_of :password, :message => " erfolglos validiert."
  validates_numericality_of :zip, :allow_nil => true

  attr_accessor :password_confirmation

  def full_name
    "#{firstname} #{lastname}"
  end
  
  def role_symbols
    self.is_admin ? [:admin] : [:user]
  end
  
  def self.authenticate(name, password)
    user = self.find_by_login(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  # 'password' is a virtual attribute
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  def after_destroy
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
  
  def name
    "#{firstname} #{lastname}"
  end

  def self.find_by_first_or_lastname(name)
    users = []
    users << User.find(:all, :conditions => ["firstname like ?", "#{name}%"])
    users << User.find(:all, :conditions => ["lastname like ?", "#{name}%"])
    users.flatten
  end
  
  def validate_new_password(password, confirmation)
    if password != confirmation 
      errors.add(:password, " confirmation failed. Please try again.")
    end
    if password.size < MINIMUM_PASSWORD_LENGTH
      errors.add(:password, " is too small. Use at least 6 characters.")
    end
  end
  
  def address
    "#{street} #{number}"
  end
  
  def location
    "#{zip} #{city}"
  end

private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def add_player
    if is_player?
      self.player = Player.create(:position => "FW")
    end
  end
  
  def generate_token
    self.token = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by { rand }.join)
  end

end