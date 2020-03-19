class Trip < ActiveRecord::Base
	acts_as_taggable
	validates_presence_of :title, :starts_at, :ends_at, :user_id
	validates_inclusion_of :private, in: [true, false]
	has_many :destinations
	has_many :entertainments
	has_many :expenses
	accepts_nested_attributes_for :destinations, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :entertainments, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :expenses, :reject_if => :all_blank, :allow_destroy => true
	validate :destination_count
	belongs_to :user
	mount_uploader :image, AvatarUploader
	acts_as_commentable
	
	scope :past, -> { where('trips.starts_at < ?', Time.now)}
	scope :upcoming, -> { where('trips.starts_at > ?', Time.now)}

	def destination_count
		if destinations.blank?
			errors.add(:base, 'Minimum one destination is required')
		end
	end

	def trip_destinations
		destinations.pluck(:name).join(' - ')
	end

	#Jan 01 - 06,2014
	def date_range
		"#{starts_at.strftime('%b %d')} - #{ends_at.strftime('%d,%Y')}"
	end

	def date_start
		"#{starts_at.strftime('%d/%m/%Y')}"
	end

	def date_end
		"#{ends_at.strftime('%d/%m/%Y')}"
	end

	#dd/mm/yyyy at HH:MM
	def created_date
		"#{created_at.strftime('%d/%m/%Y')} at #{created_at.strftime('%R')}"
	end

	def is_upcoming?
		created_at >= Time.now
	end
end
