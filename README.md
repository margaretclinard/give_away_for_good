# Give Away for Good
### NSS Back-End Capstone Project (June 2015)
### Technologies used: Ruby on Rails, HAML, Sass, Bourbon/Neat/Bitters/Refills

Created 1 month into learning Ruby on Rails at Nashville Software School, Give Away for Good is a web application built to connect community members with local non-profit needs. Non-profits can sign up to post listings for their material needs, and users can browse by non-profit or by category to donate unused possessions that they would otherwise throw away.

Live app: https://give-away-for-good.herokuapp.com/

## Project Setup

* Ruby Version: 2.2.2
* System Dependencies: Postgresql

### First Time

1. `bundle`
2. Copy `config/database.yml.example` to `config/database.yml`
3. Modify `config/database.yml` to match any particular settings necessary for your development environment
4. Run `rake db:create:all`
5. Run `rake db:migrate`
5. Run `rake db:seed`
6. Run `rake`

At the end of this process, `rake` should pass.

### Subsequently

1. `git pull`
2. `rake db:migrate`
3. `rake`
