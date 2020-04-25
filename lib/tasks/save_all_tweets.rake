namespace :save_all_tweets do
  desc "Create/Update tweets"
  task :tweet_dataset => :environment do
  	Tweet.save_all_tweets
  end
end