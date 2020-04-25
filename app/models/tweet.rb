class Tweet < ApplicationRecord
  belongs_to :user
	
	def self.save_tweet(tweet,user)
    tweet = JSON.parse(tweet.to_json)
    new_t = user.tweets.find_or_initialize_by(tweet_id: tweet["id"])
    new_t.tweet_created_at = tweet["created_at"]
    new_t.tweet_text =  tweet["text"]
    new_t.tweet_json = tweet
    new_t.user_name = tweet["user"]["name"]
    new_t.tweet_user_id =  tweet["user"]["id"]
    new_t.user_profile_url = tweet["user"]["profile_image_url_https"]
    new_t.tweet_media = tweet["extended_entities"]["media"][0]["media_url_https"] unless tweet["extended_entities"].blank?
	  new_t.save!
    puts "Tweet saved!"
	end

  #Rake task: rake save_all_tweets:tweet_dataset
  def self.save_all_tweets
    users = User.all
    if users.present?
      users.each do |user|
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV['TWITTER_KEY']
          config.consumer_secret     = ENV['TWITTER_SECRET']
          config.access_token        = user.token
          config.access_token_secret = user.secret
        end
        tweets = client.home_timeline
        unless tweets.blank?
          tweets.each_with_index do |tweet,index|
            self.save_tweet(tweet,user)
          end
        end

      end
    else
      puts "No users found!"
    end
  end
end
