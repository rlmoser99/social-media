# Facebook Clone

This is the [final project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-on-rails/lessons/final-project) in The Odin Project's Ruby on Rails curriculum. 

## Project Requirements
This project is to replicate the core functionality of Facebook using Ruby on Rails. It is not expected to use any JavaScript for this project. We will 

### Users should have the following abilities:
- Choice to sign in with devise or their facebook account.
- Upload a profile picture.
- Create posts.
- Send and receive friendship requests.
- View notifications of friendship requests.
- View newsfeed of your friend's posts
- Comment on your friend's posts
- Like your friend's posts

### Extra credit features:
- Allow users to have image-based or text-based posts.
- Use ActiveStorage to handle image uploading.
- Use Hotwire to handle realtime updates of posts, comments & likes.
- Use rake tasks to create and update sample data.

## Personal Lessons and Reflections
After completing the core project requirements, I decided to challenge myself with a few extra credit features. These features are where I really had to expand on the things that I've learned and read through a lot of new documentation.

### Polymorphism
I learned a lot about polymorphic relationships during this project. Once I began to wrap my head around it, I discovered the ability to use [delegated_type](https://mateusguimaraes.com/posts/understanding-the-delegated-type-pattern-and-multi-table-inheritance) which helped my views be more readable. 

### Cloudinary
I used ActiveStorage and [Cloudinary](https://cloudinary.com/) to handle the images for the user's profile pictures and photo posts. I wasn't entirely sure where to begin so I used this [article](https://medium.com/nerd-for-tech/getting-started-with-cloudinary-in-ruby-on-rails-6-925888032395) to point me the right direction. In hindsight, Cloudinary has great documentation and covered this same material thoroughly.

### Testing
I learned how to test each feature as I built it. Most of the time, there was relevant documentation about testing. For example, the [omniauth](https://github.com/omniauth/omniauth/wiki/Integration-Testing) gem had great documentation on testing. Occasionally, I would have to do additional research, such as how to test [ActiveStorage attachments](https://blog.eq8.eu/til/factory-bot-trait-for-active-storange-has_attached.html) or [mailers](https://www.lucascaton.com.br/2010/10/25/how-to-test-mailers-in-rails-with-rspec).

### Rake Tasks
I created a few rake tasks to help me manage the sample data. For example, I want the live demo of this app to continually update the dates of the posts, so that it will not look abandoned in 3 months. Therefore, I created a `rails db:update_sample_data` task to run every day. This task will find the seven oldest posts and update their timestamps.

### Hotwire & Turbo Streams
Even though this project specifically states to not worry about using JavaScript, I really wanted to see a comment or like appear without having to refresh the entire page. I've seen a lot of discussion about Hotwire lately, so I decided to give it a try! It doesn't work out-of-the-box with Devise and OmniAuth, so I had to rely on this [GoRail's video](https://gorails.com/episodes/devise-hotwire-turbo) and [article](https://dev.to/rbazinet/hotwire-fix-for-cors-error-when-using-omniauth-3k36) to get it working correctly. In addition, I had to remove Devise's `current_user` from my views, because Hotwire requires partials to be free of global references. 

## Local Installation
- Prerequisites: Rails, Git, and Bundler
- Clone this repo ([instructions](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository))
- Navigate into this project's directory `cd social_media`
- Install the required gems, by running `bundle install`
- Migrate the database, by running `rails db:migrate`
- Populate the database with sample data, by running `rails db:populate_sample_data` 
- Start the local server, by running `rails server`
- View `localhost:3000` in a web browser

### Running the tests
- To run the entire test suite, run `rspec`
- You can specify one spec folder to run a group tests, such as `rspec spec/system` 
- You can specify one spec file to run a single set of tests, such as `rspec spec/services/friendship_manager_spec.rb` 
