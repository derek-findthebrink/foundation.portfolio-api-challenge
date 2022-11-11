# Foundation > Portfolio API Assignment

**Author: Derek Moore**

## Introduction

 * * **STILL UNDER DEVELOPMENT** * *

The site is currently available in production with all of the assignment requirements
fulfilled. I'm currently:
- Filling out this README
- Cleaning up my code
  - removing TODO's and QUESTIONS
  - refactoring any egregious code (other than ones noted in the Refactors section below)
  - adding explanatory comments on bits of code that might be confusing
- Adding additional tests that I think are necessary and want you to see

I'll send out an email when the code is ready to go. For now though, the API is unlikely
to change so, if you would like, you can take a look at that to check it for the correct
inputs/outputs.

## Implementation Notes (Definitely Read Me)

**Routes**

The postman setup available in the root of this repo has all of the routes and params
listed, but here's a rundown of the routes available

The production host is: https://foundation--portfolio-api-chal.herokuapp.com

The available routes are:
- GET /portfolio
- GET /portfolio/holdings
- GET /portfolio/returns
- POST /portfolio/trades (create a new trade)
- PUT /portfolio/trades/:id
- DEL /portfolio/trades/:id

The routes that contain `:id` in the path need that spot to be filled by the ID of the
trade. The trade ID can be found on the route `GET /portfolio` in the trades section.

The routes `POST /portfolio/trades` and `PUT /portfolio/trades/:id` expect body
parameters, here are some samples:

POST /portfolio/trades
```json
{
    "trade": {
        "trade_type": "BUY",
        "quantity": 10,
        "symbol": "bmo",
        "price": 35
    }
}
```

PUT /portfolio/trades/:id
```json
{
    "trade": {
        "id": 1,
        "quantity": 1000,
        "price": 10,
        "symbol": "shoe",
        "trade_type": "SELL"
    }
}
```

**Changing stock prices**

Stock prices change whenever a trade is executed. The price of the stock is set to the price
of the most recent buy/sell order. For example, when the original price of "BMO" is $30.00,
and you execute a BUY trade on "BMO" for $40.00, then the new price of "BMO" will be updated
to $40.00. The same applies to SELL orders, and it doesn't matter what the quantity you put
in for the number of shares.

I did it this way because I didn't integrate it with any external API's to pull stock prices,
and I figured that this is really how stock prices are set. I'm not 100% on this, but I understand that when you're
looking at a stock ticker on TV or on a website the $ amount you're looking at is the
price of the most recent BUY/SELL order on that stock. Based on that, I figured that it would
make sense to have this system operate that way. I would have preferred to pull amounts
from an external API for sure, that would have been fun, but for now it works just on created trades.

I've seeded the DB with a couple
of stock price updates to start, but otherwise the only information the system gets about
price comes from the trades that you execute.

**Adding stocks**

Similar to the stock prices thing above, stocks are added when you execute a trade
on the POST /portfolio/trades route.

Body sample:
```json
{
    "trade": {
        "trade_type": "BUY",
        "quantity": 10,
        "symbol": "bmo",
        "price": 35
    }
}
```

**Some things aren't working quite right...**

There are some bugs in there! Definitely check out **the bugs section below**, haha. I'm
looking for solutions to 'em as I'm polishing the code and implementing missing tests,
but it's likely that they will stay in there unless y'all want me to take a closer look.

(in progress...)

## ERD

![image](https://user-images.githubusercontent.com/10052669/201326022-a45f86ce-d5d9-4546-9ff8-9d61319cb450.png)

Here's the structure of the database.

Some choices that I made:

- StockPrice has it's own table
  - Why? Good question, haha. I did this because I figured that it better matched how stock prices work in the real world, which I believe helps future developers reason about the entity. This made some of the reporting queries more difficult for this assignment (there's a bit of a scary scope on the StockPrice model, definitely something that's worth testing). On a more positive note though, it also could allow for visualizations of stock price or returns over time, which feels like something that might come up if this app were to be developed further. I like this tradeoff, but I would want to gauge the team's comfort with writing and reviewing SQL before making more scopes like this

## Local Setup

**Requirements**

- docker
- docker-compose
- ruby v3.1.2 available on path
- port 3000 on your local machine needs to be free
- port 5432 on your local machine needs to be free (no local instances of Postgres running, usually)

**Run**

- In a terminal, run `docker-compose up` and wait until the DB indicates it has started
- In a separate terminal, run the following commands from the root directory:
  - `bin/bundle`
  - `bin/rails db:create`
  - `bin/rails db:migrate`
  - `bin/rails db:seed`
  - `bin/rails serve`

The server will be available at: http://localhost:3000

## Bugs!

**purchase_cost and unrealized_gain_or_loss after a SELL is executed (GET /portfolio)**

The purchase cost field behaves a bit strangely during SELL orders. It has to do with
how the system isn't tracking the cash recouped from selling shares. This can result
in the unrealized gain/loss being off after sales

I'm debating whether or not to fix this. If there's something straight-forward I can think of I'll
do it, but it's likely that this will remain in there as it is.

**body and URL path require the same ID in order for `PUT /portfolio/trades/:id` to work**

In order for trade updating to work, both the body and the URL path require the same ID
to be present. This is silly, I'm going to try to patch this one before review so that only the URL requires
the ID.

(in progress...)

## Future Refactors & Tests

These are the refactors and tests that I would plan on doing if this was really going into
production.

### Refactors

- De-duplicate queries between reports by creating `Query` objects (/app/queries/*)
- Change trades output in `GET /portfolio` to an object with the stock symbol as a key
  - It's currently an array of trades, which isn't very easy to scan as a person (or machine, haha)
  - To help a bit I sorted the results by `{ symbol: :asc, trade_time: :asc }`

(in progress...)

### Tests

-

(in progress...)


## Postman

Here's everything you need to know to get postman up and running. The files are available
in the root of the repo.

### Setup Steps

1. Import globals into Postman from file: /portfolio-api-challenge.postman_globals.json
2. Import collection into Postman from file: /portfolio.postman_collection.json

For reference, the production URL is: https://foundation--portfolio-api-chal.herokuapp.com

### Usage Notes

**Changing params**

Most routes receive params as JSON, so you can find the params to change under the
Body tab. Under the body tab, set it to raw/JSON and go for it/have fun! Haha

## Post-Production

This section contains some things I noticed while coding that might need attention
in the future or feel like good ideas

### Possible Optimizations
- [ ] Remove any unnecessary rails modules (avoid using `require 'rails/all'` in config/application.rb)
- [ ] Add some security to the endpoints (perhaps bearer token, cors, etc.)
