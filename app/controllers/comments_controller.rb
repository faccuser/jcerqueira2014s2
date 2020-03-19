class CommentsController < ApplicationController
	def create
		@trip = Trip.where(id: params[:trip_id]).first
		@comment = @trip.comments.new(comment_params)
		@comment.save
		redirect_to @trip
	end

	private

	def comment_params
		params.require(:comment).permit(:comment, :user_id)
	end	
end
