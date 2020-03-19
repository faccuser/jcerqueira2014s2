class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope -> { order('created_at ASC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user

  #dd/mm/yyyy at HH:MM
  def created_date
  	"#{created_at.strftime('%d/%m/%Y')} at #{created_at.strftime('%R')}"
  end

end
