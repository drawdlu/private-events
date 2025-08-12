# Private Events Application

A web app that allows users to create events, make events private, invite other users, and attend other users' events.

## Features

### Main features
- User authentication
- Create events
- Attend events
- Make events private (invite only)
- Edit and delete events
- Invite and uninvite other users to private events

### Root Page
- Displays upcoming and past events
- View event details via the " see details" link on each event

### User show page
- Display events based on each category
    - Own events
    - Event invitations from other users (not yet attended)
    - Events Attending
    - Past Own Events
    - Past Events Attended

## How to install 
- Clone this repository
- Install ruby and rails
- Install bundler
    - `$ gem install bundler`
- Navigate to your cloned repository
    - `$ cd private-events`
- Install all dependencies
    - `$ bundle install`
- Migrate database
    - `$ bin/rails db:migrate`

This is part of The Odin Project Curriculum
https://www.theodinproject.com/lessons/ruby-on-rails-private-events
