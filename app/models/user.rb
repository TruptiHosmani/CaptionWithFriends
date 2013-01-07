# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base

  ajaxful_rater
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    Micropost.where("user_id = ?", id)
  end

  has_many :photos
  has_many :contests
  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :direct_friends, :through => :friendships, :conditions => "approved = 't'", :source => :friend
  has_many :inverse_friends, :through => :inverse_friendships, :conditions => "approved = 't'", :source => :user
  has_many :microposts, dependent: :destroy
  has_many :pending_friends, :through => :friendships, :conditions => "approved = 'f'", :foreign_key => "user_id", :source => :friend
  has_many :requested_friendships, :through => :inverse_friendships, :foreign_key => "friend_id", :conditions => "approved = 'f'", :source => :user

  def friends
    direct_friends | inverse_friends
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

