require 'carrierwave/orm/activerecord'
class Profile < ActiveRecord::Base
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
end
