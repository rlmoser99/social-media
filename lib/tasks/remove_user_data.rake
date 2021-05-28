# frozen_string_literal: true

namespace :db do
  desc 'Removes posts and comments from non-sample users in the database'
  task remove_user_data: :environment do
    mal = User.find_by(email: "malcolm@firefly.net")
    zoe = User.find_by(email: "zoe@firefly.net")
    wash = User.find_by(email: "wash@firefly.net")
    inara = User.find_by(email: "inara@firefly.net")
    river = User.find_by(email: "river@firefly.net")
    simon = User.find_by(email: "simon@firefly.net")
    book = User.find_by(email: "book@firefly.net")
    kaylee = User.find_by(email: "kaylee@firefly.net")
    jayne = User.find_by(email: "jayne@firefly.net")
    users = [mal, zoe, wash, inara, river, simon, book, kaylee, jayne]

    TextPost.all.map { |post| post.destroy unless users.include?(post.author) }
    PhotoPost.all.map { |post| post.destroy unless users.include?(post.author) }
    Comment.all.map { |comment| comment.destroy unless users.include?(comment.author) }
  end
end
