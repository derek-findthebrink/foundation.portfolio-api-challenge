# README

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

**Changing stock prices**

Stock prices change whenever a trade is executed. The price of the stock is set to the price
of the most recent buy/sell order. For example, when the original price of "BMO" is $30.00,
and you execute a BUY trade on "BMO" for $40.00, then the new price of "BMO" will be updated
to $40.00. The same applies to SELL orders, and it doesn't matter what the quantity you put
in for the number of shares.

I haven't integrated any API's to pull stock prices. I've seeded the DB with a couple
of stock price updates to start, but otherwise the only information the system gets about
price comes from the trades that you execute.

# Post-Production

## Possible Optimizations
- [ ] Remove any unnecessary rails modules from controllers
- [ ] Disable action mailbox
