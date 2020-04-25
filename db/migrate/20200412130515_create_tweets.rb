class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.datetime :tweet_created_at
      t.text :tweet_text
      t.text :tweet_json
      t.string :user_name
      t.string :tweet_user_id
      t.string :user_profile_url
      t.string :tweet_media
      t.references :user

      t.timestamps
    end
  end
end
