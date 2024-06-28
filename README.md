# Bonne App Petit by Jan Taras
Pennylane Recruitment Task

## Task
[Task Description](https://gist.github.com/quentindemetz/2096248a1e8d362e669350700e1e6add)

## Hosted app

[Hosted App](https://bonne-app-api-delicate-fire-1453.fly.dev/)

## Setup

### Backend Setup
For now local development is used for the repo.
Before starting, make sure that you have `postgres` `wget` and `gzip` installed on your system

If you have a Mac machine run:
```shell
brew install \
wget \
gzip \
postgresql@15
```

If you have a Linux (Debian/Ubuntu) machine run:
```shell
sudo apt-get install wget gzip
```

For installation of Postgres on Ubuntu consult the official [Ubuntu docs](https://ubuntu.com/server/docs/install-and-configure-postgresql) 


First time setup
```shell
cd bonne_app_api
bundle install
bundle exec rails db:setup
```

Run Development Server
```shell
bundle exec rails serve
```

Run Specs
```shell
bundle exec rspec
```

Download Assets for Seeding Manually
```shell
bundle exec rake recipes:download
```

### Frontend Setup

First time setup:
```shell
cd bonne_api_frontend
npm install
```

Run Development Server:
```shell
npm start
```

Build Assets:
```shell
npm run build
```

Build Assets and move them to main app (run in main project directory):
```shell
make build_frontend
```

## Solution Architecture

I decided to use monorepo pattern to divide my code.

Directory `bonne_app_api` hosts Rails 7 app,
while the React frontend is developed in `bonne_app_frontend`.

The React app produces static files which are in the build process, and
in the end hosted by Rails as SPA.

[Makefile](./Makefile) was made to facilitate the above as well as the deployment process.

### Database
Database structure is a simple many-to-many solution with 3 tables in place.

`Recipe` as the representation of recipe
`Product` as the representation of a food item
`Ingredient` as a junction object, containing data abuo the quantity used

Primary keys are in UUID, being more flexible than sequential primary keys

Unique index on the `ingredients` table was introduced to prevent allowing repeating ingredients in recipes (eggs listed twice)
Other indices were made for performance.

Database seeding automatically pulls the files with recipes if it does not detect them. It uses rake task under the hood to do so.

### Backend
Standard Rails 7 app with API.
API is versioned to allow for future growth.

Added Rubocop for styling, RSpec for tests.
Used repository pattern to host more complex queries, explained why in [./docs/01-repositories_pattern.md](this doc)

### Frontend
Frontend was made as a standard React singe page app.
Prime React components were used to design UI.
Tailwind was chosen as a styling library.

The React app is built and then served on the root endpoint of the Rails App.

### Project Tracking
I have made a simple trello board for tracking the progress, (and not to forget anything ;). I have marked all the commits with the corresponding tickets.

https://trello.com/invite/b/Px0Zsc6H/ATTI2fb78e7d591883891773e8fd4026933b294B293B/bonne-app-petit

## User Driven Design

I decided to implement 3 user stories:
1. User searches for recommended recipes from ingredients they have at home
2. User does not have oven at home, and can only make cold dishes
3. User wants to only search for recipes with certain rating

## Culture

It is vital to me for this repo to be friendly for other developers.
Therefore I have added simple instructions on installing required software, project setup and deployment.

I have made it a monorepo as for small projects with collaborators I have found this pattern to be the most productive.

## Ideas for improvements

1. React Snapshots specs with Jest
2. Adding text search to Food Selection components
3. Adding CI/CD