class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :url
      t.string :feed_url
      t.string :favicon
      t.string :last_updated
      t.string :latest_post_title
      t.integer :user_id

      t.timestamps
    end
  end
end
