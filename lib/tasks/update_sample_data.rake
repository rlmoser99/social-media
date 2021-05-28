# frozen_string_literal: true

namespace :db do
  desc 'Update the dates of sample data in the database'
  task update_sample_data: :environment do
    oldest_posts = Post.order(:created_at).limit(7)

    oldest_posts.map do |post|
      timestamp = rand(1.day.ago..Time.zone.now)
      post.update(created_at: timestamp, updated_at: timestamp)
      post.postable.update(created_at: timestamp, updated_at: timestamp)
    end
  end
end
