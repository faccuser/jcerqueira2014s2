class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :username, use: [:slugged, :history]

  validates :username, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }
  
  acts_as_followable
  acts_as_follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile
  has_many :trips
  after_create :create_profile

  def name
  	"#{firstname} #{lastname}"
  end

  def create_profile
    profile = self.profile || self.build_profile
    blob = RubyIdenticon.create(self.email)
    avatar = File.open("tmp/identicon#{self.id}.png", "wb") do |f| f.write(blob) end
    profile.avatar = File.open("tmp/identicon#{self.id}.png")
    profile.save
  end

  def self.search(query)
    where("username LIKE ? or firstname LIKE ? or lastname LIKE ?", "%#{query}%", "%#{query}%" , "%#{query}%")
  end

end
