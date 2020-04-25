class TweetsController < ApplicationController

	def create
		@user = User.find_by(id: session[:user_id])
		client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV['TWITTER_KEY']
		  config.consumer_secret     = ENV['TWITTER_SECRET']
		  config.access_token        = @user.token
      config.access_token_secret = @user.secret
		end
    unless params[:tweet][:user_profile_url].blank?
    	begin
		   tweet = client.update_with_media(params[:tweet][:tweet_text],File.new(params[:tweet][:user_profile_url].path))
       Tweet.save_tweet(tweet,@user)
       notice[:success] = "Tweet created."
      rescue Exception => e
        e.message
      end
		else
			begin
		   tweet = client.update(params[:tweet][:tweet_text])
		   Tweet.save_tweet(tweet,@user)
		   notice[:success] = "Tweet created."
      rescue Exception => e
        e.message
      end
		end
		redirect_to root_path
	end
end
