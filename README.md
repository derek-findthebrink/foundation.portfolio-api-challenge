# Foundation > Portfolio API Assignment

**Author: Derek Moore**

## Introduction

**STILL UNDER DEVELOPMENT**

The site is currently available in production with all of the assignment requirements
fulfilled. I'm currently:
- Filling out this README
- Cleaning up my code
- Adding additional tests that I think are necessary

I'll send out an email when the code is ready to go. For now though, the API is unlikely
to change so, if you would like, you can take a look at that to check it for the correct
inputs/outputs

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

**Executing a trade**

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

**Bugs**

There are some bugs in there! Definitely check out the bugs section below, haha. I'm
looking for solutions to 'em as I'm polishing the code and implementing missing tests,
but it's likely that they will stay in there unless y'all want me to take a closer look.

(in progress...)

## ERD

(in progress...)

## Local Setup

(in progress...)

## Bugs!

**Purchase cost after a SELL is executed (GET /portfolio)**

The purchase cost field behaves a bit strangely during SELL orders. It has to do with
how the system isn't tracking the cash recouped from selling shares. This can result
in the unrealized gain/loss being off after sales

I'm debating whether or not to fix this. If there's something straight-forward I can think of I'll
do it, but it's likely that this will remain in there as it is.

(in progress...)

## Future Refactors & Tests

These are the refactors and tests that I would plan on doing if this was really going into
production.

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

# Post-Production

## Possible Optimizations
- [ ] Remove any unnecessary rails modules from controllers
- [ ] Disable action mailbox
