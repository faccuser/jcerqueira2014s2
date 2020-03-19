class UsersController < ApplicationController
	
	def dashboard
		@user = current_user
		@upcoming_trips = @user.trips.upcoming
		@latest_trips = @user.trips.past
		@latest_followers = @user.followers_by_type('User').order('follows.created_at desc').limit(12) # who follow you
		@latest_followings = @user.following_by_type('User').order('follows.created_at desc').limit(12) # whom you follow
	end

	def network
		@user = current_user
		@followings = @user.following_by_type('User').order('follows.created_at desc') # whom you follow
	end

	def followers
		@user = current_user
		@followers = @user.followers_by_type('User').order('follows.created_at desc')# who follow you
	end

	def search_users
		if params[:search]
      		@users_list = User.search(params[:search]).order("created_at DESC")
    	else
      		@users_list = "";
    	end
	end

	def followings
		@user = current_user
		@followings = @user.following_by_type('User').order('follows.created_at desc') # whom you follow
		@followers = @user.followers_by_type('User').order('follows.created_at desc')# who follow you
	end

	def tags
		if params[:tag]
    		@trips = Trip.tagged_with(params[:tag])
  		else
    		@trips = Trip.all
  		end
	end

	def settings
		@profile = current_user.profile
		@user = current_user
	end

	def update_profile
		@profile = current_user.profile
		if @profile.update_attributes(profile_params) 
			redirect_to '/settings', flash: {message: 'Profile Updated Successfully'}
		else
			render 'settings'
		end
	end

	def update_password
	    @user = User.find(current_user.id)
	    if @user.update(user_params)
	      # Sign in the user by passing validation in case his password changed
	      sign_in @user, :bypass => true
	      redirect_to root_path
	    else
	      render '/settings'
	    end
  	end

	def show
		@user = User.friendly.find(params[:id])
	end

	def edit
    	@user = current_user
  	end

	def follow
	  	@user = User.friendly.find(params[:user_id])
	    if current_user == @user
	      flash[:error] = "You cannot follow yourself."
	    else
	      current_user.follow(@user)
	      flash[:notice] = "You are now following #{@user.username}."
	    end
	    redirect_to @user
	end

	def unfollow
	  	@user = User.friendly.find(params[:user_id])
	    current_user.stop_following(@user)
	    flash[:notice] = "You are no longer following #{@user.username}."
	    redirect_to @user
	end

	private

	def profile_params
    	params.require(:profile).permit(:avatar)
	end

	def user_params
    	# NOTE: Using `strong_parameters` gem
    	params.required(:user).permit(:password, :password_confirmation)
  	end

end
