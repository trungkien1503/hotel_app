# Hotels data merge

In any hotels site, there's a lot of effort being made to present content in a clean & organised manner. Underneath the hood however, the data procurement process is complex and data is often mismatched & dirty.

This exercise gives you a sneak peak in some of the actions we take to clean up data before it makes it to the site

- we are querying multiple suppliers to assimilate data for these different sources
- we are building the most complete data set possible
- we are sanitizing them to remove any dirty data
- etc.

The task is to write a simplified version of our data procurement & merging proceess.

It needs to work in the following way:

## Requirements

1. Merge hotel data of different suppliers
  1. Parse and clean dirty data
  2. Select what you think is the best data to deliver using some simple rules
2. Deliver it via an API endpoint by you which allows us to query the hotels data with some simple filtering

...

Full details: https://gist.github.com/longkt90/03e70f63d1844f426d8062232861d5f1

## What I got

I build this app using Ruby on Rails framework as a web server.

- Crawl hotel data (get and merge data by some simple rules) from provided suppliers
- Crawling data react dynamically over time when adding/ removing a hotel from 1 of the supplier datasets
- Schedule updating data every 10 minutes
- Build admin site to view and manage data
- Build API endpoint to query hotels data
- Check code with rubocop and rails_best_practices
- Write spec tests
- Deploy code to heroku: https://ascenda-hotels.herokuapp.com/

## How to use

1. Clone this app branch `master` to the local environment
2. Install Ruby and Rails as detail in Gemfile
3. Run `bundle install` to install missing gems
4. Setup the local environment
    - Run `rake db:create`
    - Run `rake db:migrate`
5. Get and merge hotels data from suppliers to your local database
    - Run `rake hotel_data:crawl`
6. Start your web server `rails s`
7. Open `localhost:3000` to check list APIs doc
8. Open `localhost:3000/admin` to go to admin site
9. Open `localhost:3000/v1/hotels.json?destination_id=5432&hotels=iJhz,SjyX` to check api list of hotels
10. Open `localhost:3000/v1/hotels/iJhz.json` to check api detail of a hotel

## Structure
- `api/v1/hotels_controller.rb` to build controller handling requests (thin controller, not put logic in controllers)
- `config/routes.rb` define routing
- `app/models/hotel.rb` write some logic
- `app/services/hotel_service.rb` the large logic should be put in services not in model
- `lib/tasks/hotel_data.rake` rake task to crawl hotel data
- `app/views/api/v1` views file (ex: build json view for list of hotels)
- `app/docs/hotels` build api doc here, not put in controller
- `spec/controller`, `spec/requests/api/v1/`, `spec/routing` test cases here

## Deploy

Deploy code to heroku
- URL: https://ascenda-hotels.herokuapp.com/

## URLs
- Admin Url: https://ascenda-hotels.herokuapp.com/admin/hotel
- APIs doc: https://ascenda-hotels.herokuapp.com/
- Example api doc: https://ascenda-hotels.herokuapp.com/apipie/1.0/hotels/index.html
- Api list of hotels: https://ascenda-hotels.herokuapp.com/v1/hotels.json?destination_id=5432&hotels=iJhz,SjyX
- Api detail of a hotel: https://ascenda-hotels.herokuapp.com/v1/hotels/iJhz.json

## Test cases
- Write some spec code in spec/
- Run command to verify test cases `rspec spec/`

## Code quality
Verified code with:
- https://github.com/rubocop-hq/rubocop
- https://github.com/flyerhzm/rails_best_practices

## Bonus
- Schedule updating hotel data every 10 minutes by https://devcenter.heroku.com/articles/scheduler
- Build admin page to manage data (without authentication, can apply later)
- Build Api doc page to help understand api parameters, response better

## Ideas for the next step
- Add authentication for admin site
- Add swagger to test api more easier
- Build front-end pages using JS framework(ex: AngularJS, ReactJS, or VueJS)
- Add more test cases
- Update rules for merging data if receiving more detail of requirements
