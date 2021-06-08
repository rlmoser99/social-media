# frozen_string_literal: true

namespace :db do
  desc 'Populates the database with sample data'
  task populate_sample_data: :environment do

    # Deletes sample users because anyone can log in with these accounts
    User.find_by(email: "malcolm@firefly.net")&.destroy
    User.find_by(email: "zoe@firefly.net")&.destroy
    User.find_by(email: "wash@firefly.net")&.destroy
    User.find_by(email: "inara@firefly.net")&.destroy
    User.find_by(email: "river@firefly.net")&.destroy
    User.find_by(email: "simon@firefly.net")&.destroy
    User.find_by(email: "book@firefly.net")&.destroy
    User.find_by(email: "kaylee@firefly.net")&.destroy
    User.find_by(email: "jayne@firefly.net")&.destroy
    User.find_by(email: "username@firefly.net")&.destroy

    # Resets other user's notification count caused by user deletion.
    User.all.map { |user| user.update(unread_notifications_count: 0) }

    # Turns off Devise's mailers and creates 9 sample users
    Devise::Mailer.perform_deliveries = false

    mal = User.create(first_name: "Malcolm",
                      last_name: "Reynolds",
                      email: "malcolm@firefly.net",
                      password: "serenity",
                      password_confirmation: "serenity")

    zoe = User.create(first_name: "Zoe",
                      last_name: "Washburne",
                      email: "zoe@firefly.net",
                      password: "serenity",
                      password_confirmation: "serenity")

    wash = User.create(first_name: "Hoban",
                       last_name: "Washburne",
                       email: "wash@firefly.net",
                       password: "serenity",
                       password_confirmation: "serenity")

    inara = User.create(first_name: "Inara",
                        last_name: "Serra",
                        email: "inara@firefly.net",
                        password: "serenity",
                        password_confirmation: "serenity")

    river = User.create(first_name: "River",
                        last_name: "Tam",
                        email: "river@firefly.net",
                        password: "serenity",
                        password_confirmation: "serenity")

    simon = User.create(first_name: "Simon",
                        last_name: "Tam",
                        email: "simon@firefly.net",
                        password: "serenity",
                        password_confirmation: "serenity")

    book = User.create(first_name: "Shepherd",
                       last_name: "Book",
                       email: "book@firefly.net",
                       password: "serenity",
                       password_confirmation: "serenity")

    kaylee = User.create(first_name: "Kaylee",
                        last_name: "Frye",
                        email: "kaylee@firefly.net",
                        password: "serenity",
                        password_confirmation: "serenity")

    jayne = User.create(first_name: "Jayne",
                        last_name: "Cobb",
                        email: "jayne@firefly.net",
                        password: "serenity",
                        password_confirmation: "serenity")

    User.create(first_name: "Mr.",
                last_name: "Universe",
                email: "username@firefly.net",
                password: "serenity",
                password_confirmation: "serenity")

    # Turns back on Devise's mailers
    Devise::Mailer.perform_deliveries = true

    # Attach an avatar and create friendships for the initial 9 users
    users = [mal, zoe, wash, inara, river, simon, book, kaylee, jayne]

    users.each do |user|
      filename = "#{user.first_name}.jpeg"
      user.avatar.attach(io: File.open("app/assets/images/sample_data/#{filename}"), filename: filename.to_s, content_type: 'image/jpeg')
    end

    users.repeated_combination(2).to_a.each do |pair|
      next if pair[0] == pair[1]

      request = FriendshipRequest.create(user_id: pair[0].id, requested_friend_id: pair[1].id)
      request.update(status: "accepted")
      Friendship.create(user_id: pair[0].id, friend_id: pair[1].id)
      Friendship.create(user_id: pair[1].id, friend_id: pair[0].id)
    end

    # Create Sample Text and Photo Posts
    statue = TextPost.create(author: mal, content: "Jayne? Why is there a statue of you in the middle of this town square?")
    Post.create(postable: statue, author: statue.author)
    Comment.create(author: jayne, commentable: statue, content: "Don't rightly know myself")
    Comment.create(author: simon, commentable: statue, content: "This must be what going mad feels like.")
    Like.create(author: jayne, likeable: statue)
    Like.create(author: wash, likeable: statue)

    crooks = TextPost.create(author: wash, content: "Sweetie, we're crooks. If everything were right, we'd be in jail.")
    Post.create(postable: crooks, author: crooks.author)
    Like.create(author: zoe, likeable: crooks)

    bible = TextPost.create(author: zoe, content: "Preacher, don't the Bible have some pretty specific things to say about killing?")
    Post.create(postable: bible, author: bible.author)
    Comment.create(author: book, commentable: bible, content: "Quite specific. It is, however, somewhat fuzzier on the subject of kneecaps.")
    Like.create(author: mal, likeable: bible)
    Like.create(author: jayne, likeable: bible)
    Like.create(author: zoe, likeable: bible)

    ship = TextPost.create(author: simon, content: "My sister's a ship...We had a complicated childhood.")
    Post.create(postable: ship, author: ship.author)

    cheerful = TextPost.create(author: jayne, content: "Can you stop her from bein' so cheerful?")
    Post.create(postable: cheerful, author: cheerful.author)
    Comment.create(author: mal, commentable: cheerful, content: "I don't believe there is a power in the verse that can stop Kaylee from being cheerful.")
    Like.create(author: kaylee, likeable: cheerful)
    Like.create(author: inara, likeable: cheerful)
    Like.create(author: river, likeable: cheerful)
    Like.create(author: simon, likeable: cheerful)

    thrust = TextPost.create(author: kaylee, content: "I had to rewire the grav thrust because somebody won't replace that crappy compression coil.")
    Post.create(postable: thrust, author: thrust.author)
    Like.create(author: simon, likeable: thrust)

    shuttle = TextPost.create(author: inara, content: "What did I say to you about barging into my shuttle?")
    Post.create(postable: shuttle, author: shuttle.author)
    Comment.create(author: mal, commentable: shuttle, content: "That it was manly and impulsive?")
    Comment.create(author: inara, commentable: shuttle, content: "Yes, precisely. Only the exact phrase I used was... don't.")
    Like.create(author: kaylee, likeable: shuttle)

    gorram = TextPost.create(author: mal, content: "Just once I'd like things to go according to the gorram plan.")
    Post.create(postable: gorram, author: gorram.author)

    mouth = TextPost.create(author: jayne, content: "Ten percent of nothing is, let me do the math here, nothing into nothing, carry the nothin'...")
    Post.create(postable: mouth, author: mouth.author)
    Comment.create(author: mal, commentable: mouth, content: "Jayne, your mouth is talking. You might wanna look to that.")
    Like.create(author: wash, likeable: mouth)

    blue = TextPost.create(author: river, content: "Two by two. Hands of blue. Two by two.")
    Post.create(postable: blue, author: blue.author)

    grace = TextPost.create(author: book, content: "Captain, you mind if I say grace?")
    Post.create(postable: grace, author: grace.author)
    Comment.create(author: mal, commentable: grace, content: "Only if you say it out loud.")

    abbey = TextPost.create(author: book, content: "I've been out of the abbey two days, I've beaten a lawman senseless, I've fallen in with criminals. I watched the captain shoot the man I swore to protect. And I'm not even sure if I think he was wrong.")
    Post.create(postable: abbey, author: abbey.author)
    Like.create(author: zoe, likeable: abbey)
    Like.create(author: mal, likeable: abbey)

    prodigy = TextPost.create(author: mal, content: "So, she's added cussing and hurling about of things to her repertoire. She really is a prodigy.")
    Post.create(postable: prodigy, author: prodigy.author)
    Comment.create(author: simon, commentable: prodigy, content: "It's just a bad day.")
    Comment.create(author: mal, commentable: prodigy, content: "No, a bad day is when someone's yellin' spooks the cattle. Understand?")
    Comment.create(author: river, commentable: prodigy, content: "The human body can be drained of blood in 8.6 seconds given adequate vacuuming systems.")
    Comment.create(author: mal, commentable: prodigy, content: "See, morbid and creepifying, I got no problem with, long as she does it quiet-like.")
    Like.create(author: jayne, likeable: prodigy)

    funny = TextPost.create(author: kaylee, content: "Captain seem a little funny to you at breakfast this morning?")
    Post.create(postable: funny, author: funny.author)
    Comment.create(author: wash, commentable: funny, content: "Come on, Kaylee. We all know I'm the funny one.")
    Like.create(author: wash, likeable: funny)

    train = TextPost.create(author: zoe, content: "Sir, is there some information we might maybe be lacking as to why there's an entire fed squad sitting on this train?")
    Post.create(postable: train, author: train.author)
    Comment.create(author: mal, commentable: train, content: "Doesn't concern us.")
    Comment.create(author: zoe, commentable: train, content: "It kinda concerns me.")
    Like.create(author: inara, likeable: train)
    Like.create(author: simon, likeable: train)

    dino = TextPost.create(author: wash, content: "(as a stegosaurus) Ah, curse your sudden but inevitable betrayal!")
    Post.create(postable: dino, author: dino.author)
    Like.create(author: zoe, likeable: dino)

    swan = TextPost.create(author: inara, content: "Does it seem every supply store on every border planet has the same five rag dolls and the same wood carvings of... what is this? A duck?")
    Post.create(postable: swan, author: swan.author)
    Comment.create(author: kaylee, commentable: swan, content: "It's a swan. I like it.")
    Comment.create(author: inara, commentable: swan, content: "You do?")
    Comment.create(author: kaylee, commentable: swan, content: "Looks like it was made with, you know, longing. Made by a person really longed to see a swan.")
    Comment.create(author: inara, commentable: swan, content: "Perhaps they'd only heard of them by rough description.")
    Like.create(author: simon, likeable: swan)
    Like.create(author: river, likeable: swan)

    remember = TextPost.create(author: river, content: "I get confused. I remember everything. I remember too much, and... some of its made up, and... some of it can't be quantified, and... there's secrets.")
    Post.create(postable: remember, author: remember.author)
    Like.create(author: simon, likeable: remember)

    spices = TextPost.create(author: book, content: "The important thing is the spices. A man can live on packaged food from here ’til Judgment Day if he’s got enough rosemary.")
    Post.create(postable: spices, author: spices.author)
    Like.create(author: kaylee, likeable: spices)
    Like.create(author: inara, likeable: spices)
    Like.create(author: river, likeable: spices)

    lecture = TextPost.create(author: inara, content: "Would you like to lecture me on the wickedness of my ways?")
    Post.create(postable: lecture, author: lecture.author)
    Comment.create(author: book, commentable: lecture, content: "No, I brought you supper. Although if you'd prefer a lecture, I've a few very catchy ones prepped. Sin and hellfire... one has lepers.")
    Like.create(author: book, likeable: lecture)

    hankie = TextPost.create(author: zoe, content: "Knew a man who had a hole clean through his whole shoulder, once. Used to keep a spare hankie in there.")
    Post.create(postable: hankie, author: hankie.author)
    Like.create(author: mal, likeable: hankie)

    cows = TextPost.create(author: river, content: "They weren't cows inside. They were waiting to be, but they forgot. Now they see the sky and they remember what they are.")
    Post.create(postable: cows, author: cows.author)
    Comment.create(author: mal, commentable: cows, content: "Is it bad that what she said made perfect sense to me?")
    Like.create(author: mal, likeable: cows)

    flying = TextPost.create(author: wash, content: "Oh my god. What can it be? We're all doomed! Who's flying this thing!? ... Oh right, that would be me. Back to work.")
    Post.create(postable: flying, author: flying.author)
    Like.create(author: zoe, likeable: flying)
    Like.create(author: kaylee, likeable: flying)

    leg = TextPost.create(author: simon, content: "I once reattached a girl's leg. Her whole leg. She named her hamster after me. I got a hamster. Jayne drops a box of money and he gets a town.")
    Post.create(postable: leg, author: leg.author)
    Comment.create(author: kaylee, commentable: leg, content: "Hamsters is nice.")
    Like.create(author: kaylee, likeable: leg)

    heavy = TextPost.create(author: kaylee, content: "We tried to get Jayne into the infirmary, he's just heavy.")
    Post.create(postable: heavy, author: heavy.author)
    Like.create(author: simon, likeable: heavy)

    kill = TextPost.create(author: simon, content: "Um, I’m trying to put this as delicately as I can… how do I know you won’t kill me in my sleep?")
    Post.create(postable: kill, author: kill.author)
    Comment.create(author: mal, commentable: kill, content: "Listen, you don’t know me, son, so I’m gonna say this once: if I ever kill you, you’ll be awake, you’ll be facing me, and you’ll be armed.")
    Comment.create(author: simon, commentable: kill, content: "Are you always this sentimental?")
    Comment.create(author: mal, commentable: kill, content: "I had a good day.")
    Comment.create(author: simon, commentable: kill, content: "You had the Alliance on you, criminals and savages… half the people on this ship have been shot or wounded, including yourself, and you’re harboring known fugitives.")
    Comment.create(author: mal, commentable: kill, content: "We’re still flying.")
    Comment.create(author: simon, commentable: kill, content: "That’s not much.")
    Comment.create(author: mal, commentable: kill, content: "It’s enough.")
    Like.create(author: kaylee, likeable: kill)
    Like.create(author: river, likeable: kill)
    Like.create(author: jayne, likeable: kill)
    Like.create(author: book, likeable: kill)
    Like.create(author: simon, likeable: kill)

    # crew = PhotoPost.find_or_initialize_by(author: mal, description: "We've done the impossible, and that makes us mighty.")
    crew = PhotoPost.new(author: mal, description: "We've done the impossible, and that makes us mighty.")
    crew.image.attach(io: File.open("app/assets/images/sample_data/crew.jpeg"), filename: "crew", content_type: 'image/jpeg')
    crew.save
    Post.create(postable: crew, author: crew.author)
    Like.create(author: wash, likeable: crew)
    Like.create(author: zoe, likeable: crew)
    Like.create(author: river, likeable: crew)
    Like.create(author: simon, likeable: crew)
    Like.create(author: kaylee, likeable: crew)
    Like.create(author: inara, likeable: crew)
    Like.create(author: book, likeable: crew)
    Like.create(author: jayne, likeable: crew)

    # umbrella = PhotoPost.find_or_initialize_by(author: kaylee, description: "You're going to come with us.")
    umbrella = PhotoPost.new(author: kaylee, description: "You're going to come with us.")
    umbrella.image.attach(io: File.open("app/assets/images/sample_data/umbrella.jpeg"), filename: "umbrella", content_type: 'image/jpeg')
    umbrella.save
    Post.create(postable: umbrella, author: umbrella.author)
    Comment.create(author: book, commentable: umbrella, content: "Excuse me?")
    Comment.create(author: kaylee, commentable: umbrella, content: "You like ships. You don't seem to be looking at the destinations. Whatcha care about is the ships and mines the nicest.")
    Comment.create(author: book, commentable: umbrella, content: "Don't look like much.")
    Comment.create(author: kaylee, commentable: umbrella, content: "Ah, she'll fool ya. You ever sail in a Firefly?")
    Comment.create(author: book, commentable: umbrella, content: "Long before you were crawling. Not an ought three though. Didn't have the extenders. Tended to shake.")
    Comment.create(author: kaylee, commentable: umbrella, content: "So, ah, how come you don't care where you're going?")
    Comment.create(author: book, commentable: umbrella, content: "'Cause how you get there is the worthier part.")
    Like.create(author: simon, likeable: umbrella)
    Like.create(author: river, likeable: umbrella)
    Like.create(author: book, likeable: umbrella)

    # jayne_hat = PhotoPost.find_or_initialize_by(author: jayne, description: "How's it sit? Pretty cunning, don't you think?")
    jayne_hat = PhotoPost.new(author: jayne, description: "How's it sit? Pretty cunning, don't you think?")
    jayne_hat.image.attach(io: File.open("app/assets/images/sample_data/hat.jpeg"), filename: "hat", content_type: 'image/jpeg')
    jayne_hat.save
    Post.create(postable: jayne_hat, author: jayne_hat.author)
    Comment.create(author: kaylee, commentable: jayne_hat, content: "I think it's the sweetest hat ever.")
    Comment.create(author: wash, commentable: jayne_hat, content: "A man walks down the street in that hat, people know he's not afraid of anything.")
    Comment.create(author: jayne, commentable: jayne_hat, content: "Damn straight.")
    Like.create(author: kaylee, likeable: jayne_hat)
    Like.create(author: wash, likeable: jayne_hat)

    # Randomize the timestamp, so they don't all look like they were created at the exact same time
    Post.all.map do |post|
      timestamp = rand(1.day.ago..Time.zone.now)
      post.update(created_at: timestamp, updated_at: timestamp)
      post.postable.update(created_at: timestamp, updated_at: timestamp)
    end
  end
end
