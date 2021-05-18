# frozen_string_literal: true

namespace :db do
  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do
    mal = User.find_or_create_by(first_name: "Malcolm", last_name: "Reynolds", email: "malcolm@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    zoe = User.find_or_create_by(first_name: "Zoe", last_name: "Washburne", email: "zoe@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    wash = User.find_or_create_by(first_name: "Hoban", last_name: "Washburne", email: "wash@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    inara = User.find_or_create_by(first_name: "Inara", last_name: "Serra", email: "inara@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    river = User.find_or_create_by(first_name: "River", last_name: "Tam", email: "river@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    simon = User.find_or_create_by(first_name: "Simon", last_name: "Tam", email: "simon@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    book = User.find_or_create_by(first_name: "Shepherd", last_name: "Book", email: "book@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    kaylee = User.find_or_create_by(first_name: "Kaylee", last_name: "Frye", email: "kaylee@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    jayne = User.find_or_create_by(first_name: "Jayne", last_name: "Cobb", email: "jayne@firefly.net") do |user|
      user.password = "serenity"
      user.password_confirmation = "serenity"
    end

    users = [mal, zoe, wash, inara, river, simon, book, kaylee, jayne]

    users.each do |user|
      next if user.avatar.attached?

      filename = "#{user.first_name}.jpeg"
      user.avatar.attach(io: File.open("app/assets/images/seed_avatars/#{filename}"), filename: filename.to_s, content_type: 'image/jpeg')
    end

    users.repeated_combination(2).to_a.each do |pair|
      next if pair[0] == pair[1]

      request = FriendshipRequest.find_or_create_by(user_id: pair[0].id, requested_friend_id: pair[1].id)
      request.update(status: "accepted")
      Friendship.find_or_create_by(user_id: pair[0].id, friend_id: pair[1].id)
      Friendship.find_or_create_by(user_id: pair[1].id, friend_id: pair[0].id)
    end

    statue = TextPost.find_or_create_by(author: mal, content: "Jayne? Why is there a statue of you in the middle of this town square?")
    Post.find_or_create_by(postable: statue, author: statue.author)
    Comment.find_or_create_by(author: jayne, commentable: statue, content: "Don't rightly know myself")
    Comment.find_or_create_by(author: simon, commentable: statue, content: "This must be what going mad feels like.")

    bible = TextPost.find_or_create_by(author: zoe, content: "Preacher, don't the Bible have some pretty specific things to say about killing?")
    Post.find_or_create_by(postable: bible, author: bible.author)
    Comment.find_or_create_by(author: book, commentable: bible, content: "Quite specific. It is, however, somewhat fuzzier on the subject of kneecaps.")

    cheerful = TextPost.find_or_create_by(author: river, content: "Can you stop her from bein' so cheerful?")
    Post.find_or_create_by(postable: cheerful, author: cheerful.author)
    Comment.find_or_create_by(author: mal, commentable: cheerful, content: "I don't believe there is a power in the verse that can stop Kaylee from being cheerful.")

    mouth = TextPost.find_or_create_by(author: jayne, content: "Ten percent of nothing is, let me do the math here, nothing into nothing, carry the nothin'...")
    Post.find_or_create_by(postable: mouth, author: mouth.author)
    Comment.find_or_create_by(author: mal, commentable: mouth, content: "Jayne, your mouth is talking. You might wanna look to that.")

    grace = TextPost.find_or_create_by(author: book, content: "Captain, you mind if I say grace?")
    Post.find_or_create_by(postable: grace, author: grace.author)
    Comment.find_or_create_by(author: mal, commentable: grace, content: "Only if you say it out loud.")

    prodigy = TextPost.find_or_create_by(author: mal, content: "So, she's added cussing and hurling about of things to her repertoire. She really is a prodigy.")
    Post.find_or_create_by(postable: prodigy, author: prodigy.author)
    Comment.find_or_create_by(author: simon, commentable: prodigy, content: "It's just a bad day.")
    Comment.find_or_create_by(author: mal, commentable: prodigy, content: "No, a bad day is when someone's yellin' spooks the cattle. Understand?")
    Comment.find_or_create_by(author: river, commentable: prodigy, content: "The human body can be drained of blood in 8.6 seconds given adequate vacuuming systems.")
    Comment.find_or_create_by(author: mal, commentable: prodigy, content: "See, morbid and creepifying, I got no problem with, long as she does it quiet-like.")

    swan = TextPost.find_or_create_by(author: inara, content: "Does it seem every supply store on every border planet has the same five rag dolls and the same wood carvings of... what is this? A duck?")
    Post.find_or_create_by(postable: swan, author: swan.author)
    Comment.find_or_create_by(author: kaylee, commentable: swan, content: "It's a swan. I like it.")
    Comment.find_or_create_by(author: inara, commentable: swan, content: "You do?")
    Comment.find_or_create_by(author: kaylee, commentable: swan, content: "Looks like it was made with, you know, longing. Made by a person really longed to see a swan.")
    Comment.find_or_create_by(author: inara, commentable: swan, content: "Perhaps they'd only heard of them by rough description.")

    hat = TextPost.find_or_create_by(author: jayne, content: "How's it sit? Pretty cunning, don't you think?")
    Post.find_or_create_by(postable: hat, author: hat.author)
    Comment.find_or_create_by(author: kaylee, commentable: hat, content: "I think it's the sweetest hat ever.")
    Comment.find_or_create_by(author: wash, commentable: hat, content: "A man walks down the street in that hat, people know he's not afraid of anything.")
    Comment.find_or_create_by(author: jayne, commentable: hat, content: "Damn straight.")

    lecture = TextPost.find_or_create_by(author: inara, content: "Would you like to lecture me on the wickedness of my ways?")
    Post.find_or_create_by(postable: lecture, author: lecture.author)
    Comment.find_or_create_by(author: book, commentable: lecture, content: "No, I brought you supper. Although if you'd prefer a lecture, I've a few very catchy ones prepped. Sin and hellfire... one has lepers.")

    kill = TextPost.find_or_create_by(author: simon, content: "Um, I’m trying to put this as delicately as I can… how do I know you won’t kill me in my sleep?")
    Post.find_or_create_by(postable: kill, author: kill.author)
    Comment.find_or_create_by(author: mal, commentable: kill, content: "Listen, you don’t know me, son, so I’m gonna say this once: if I ever kill you, you’ll be awake, you’ll be facing me, and you’ll be armed.")
    Comment.find_or_create_by(author: simon, commentable: kill, content: "Are you always this sentimental?")
    Comment.find_or_create_by(author: mal, commentable: kill, content: "I had a good day.")

    cows = TextPost.find_or_create_by(author: river, content: "They weren't cows inside. They were waiting to be, but they forgot. Now they see the sky and they remember what they are.")
    Post.find_or_create_by(postable: cows, author: cows.author)
    Comment.find_or_create_by(author: mal, commentable: cows, content: "Is it bad that what she said made perfect sense to me?")
  end
end
