# Monte Cinema 🎬

## Technologies

- Ruby 3.0.1
- Rails 6.1.3.2
- Bundler 2.2.15
- PostgreSQL 13.2
- Sidekiq 6.2.1

## Instalation

```
# Clone the repository localy:
$ git clone https://github.com/kodowicz/monte-cinema.git

# Install required gems:
$ bundle install

# Create database with basic seeds:
$ rake db:create
$ rake db:migrate
$ rake db:seed

# Run server
$ rails server
```

Now the application is ready to use on http://localhost:3000

## Application requirements

### Must have:

**Functional requirements:**
- [x] Endpoint to buy tickets/create reservation from ticket desk
- [x] Endpoint to buy tickets/create reservation from online application
- [x] Endpoint to present movies and their screenings with pagination
- [x] Mechanism to terminate reservation if somebody did not pay ~30 minutes before screening (for reservations created by online application)
- [x] Creating reservation should be robust and there should be validations (for instance - for already taken seats etc.). 

**Email communication:**
- [ ] When user gets registered (welcome email)
- [ ] When reservation is created (tickets, seats and price should be attached)
- [ ] When reservation is terminated (the reason should be attached)

**User:**
- [x] Authentication (logging by user and by employer)
- [x] Authorization in terms of role-based separation
- [x] Regular user should have ability to create only online reservation
- [x] Employer should have ability to create online reservation but also offline reservation

**Not functional requirements:**
- [ ] API should be documented 
- [x] Application should have provided seeds and should be generally operational
- [ ] At least 80% of tests coverage
- [ ] Application should have connected Sentry and CircleCI
- [x] Application should be accessible publicly (for instance by Heroku)
- [x] Application should have configured rubocop and should fulfill all rubocop requirements.

### Nice to have:
- [ ] JSON:API endpoint
- [ ] GraphQL endpoint
- [ ] File upload (for instance avatar for user)
- [ ] Other functionalities like adding new movies, screenings, cinema halls


Monterail Rubycamp 2021
