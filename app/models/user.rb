require 'digest/sha1'
include ActionView::Helpers::UrlHelper

class User < ActiveRecord::Base

  has_many :topics
  has_many :posts
  has_many :messages
  has_many :news
  has_many :resource_settings
  
  has_one :user_picture
  has_one :player, :dependent => :destroy
  has_one :subscription_manager, :dependent => :destroy
  
  has_and_belongs_to_many :events, :order => "Date ASC"
  has_and_belongs_to_many :games, :order => "Date ASC", :join_table => "events_users", :association_foreign_key => "event_id"
  
  before_create :generate_token
  after_create :add_player, :add_subscription_manager
  
  ::MINIMUM_PASSWORD_LENGTH = 6
  
  validates_presence_of     :lastname, :firstname
  validates_uniqueness_of   :login
  validates_format_of       :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :allow_blank => true
  validates_confirmation_of :password, :message => " erfolglos validiert."
  validates_numericality_of :zip, :allow_nil => true

  attr_accessor :password_confirmation
  
  default_scope order('lastname')

  def full_name
   name
  end
  
  def email_with_name
    "#{name} <#{email}>"
  end
  
  def role_symbols
    roles = [:user]
    if is_admin
      roles = [:admin]
    elsif is_chair_member
      roles = [:chair_member]
    end
    roles
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
  
  def name
    "#{firstname} #{lastname}"
  end
  
  def to_s
    name
  end

  def self.find_by_first_or_lastname(name)
    users = []
    users << where("firstname like ?", "#{name}%")
    users << where("lastname like ?", "#{name}%")
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
  
  def active
    is_player ? "ja" : "nein"
  end
  
  def self.number_of_active_players
    where("is_player = ?", true).size
  end
  
  def events_to_ical(host)
    cal = Icalendar::Calendar.new 
    events.each do |event|
      event_url = event_link(host, event)
      cal.event do
        dtstart       event.start_time.strftime("%Y%m%dT%H%M%S")
        dtend         event.end_time.strftime("%Y%m%dT%H%M%S")
        summary       "#{event.name}"
        location      event.locality
        uid           event.ical_id
        url           event_url
      end
    end
    cal.to_ical
  end
  
  def events_of_current_season
    season = Season.current
    self.events.find_all_by_season_id(season.id)
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
  
  def add_subscription_manager
     unless self.subscription_manager
       self.subscription_manager = SubscriptionManager.create
     end
  end
  
  def generate_token
    self.token = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by { rand }.join)
  end
  
  def event_link(host, event)
    url_for(:host => host, :controller => event.controller_name, :action => "show", :id => event.to_param)
  end
  
end