# Tanooki Bakery

Tanooki Bakery is an artisanal digital bakery, crafting the finest digital
cookies in New York City.

We don't mass produce our cookies in faceless factories. Instead, We bake
cookies to order, one at a time.



## Reference Application

A reference application can be found at
[http://tanooki-bakery.herokuapp.com](http://tanooki-bakery.herokuapp.com)

HTTP Auth access: bake / somecookies

## Backlog:

### Bug: React console warning 
When visiting the Order Listing page, I see the following warning:

"Warning: Each child in an array or iterator should have a unique "key" prop."

We should resolve this.


### Feature: As a bakery owner, I should be able to place a sheet with multiple cookies into an oven
Given I have an oven

When I am on the oven page

Then I should be able to prepare a batch of cookies with the same filling

When the batch of cookies is finished cooking

Then I should be able to remove the cookies into my store inventory


### Feature: cookies should actually be cooked
We lazily added to Cookie: def ready?; true; end

But, the cookies are not actually ready instantly! When a cookie is placed in the oven, we need to trigger a background cooking worker to cook the cookies and update their state after a couple minutes of "cooking"

### Feature: As a bakery owner, I should see the oven page update automatically when the cookies are ready
Given I have unfinished cookies in an oven

And I am on the oven page

Then I should see that the cookies are not yet ready

When the cookies finish cooking

Then I should see that the cookies are ready

Note: This can be non-instant (e.g. performed through periodic polling is acceptable), but only the relevant part of the page should update

### Feature: Add loading indicator for Order Listing
Given there are orders in the system

When I visit the orders page

Then I should see a loading indicator that signifies that order data is being fetched

When the data has finished loading

Then I see the order listing

### Feature: Sorting order listing table
Given there are orders in the system

When I visit the orders page

Then I should see "Order #", "Customer Name" and "Pick up at" column headers underlined, signifying that i can click on the header to sort the column

When I click on a sortable column header

Then the data in the table is reordered by that particular column in ascending order

### Feature: Marking orders fulfilled
Given there are orders in the system

When I visit the orders page

Then I should see that unfulfilled (in progress) orders have a button in the actions column called "Fulfill order".

When I click on "Fulfill order"

Then the button for that row becomes disabled

When the order has been fulfilled (by API call)
The button for that row disappears
And the order status for that row is updated

When I refresh the page
I can see that the order status still says Fulfilled


## Test Suite

Like most bakeries, Tanooki Bakery has a test suite. The full suite can be run
with:

```bash
rspec spec
```

## Database Seed Data

```bash
rake db:seed
```

## Dependency Installation

```bash
bundle install
yarn install
```

## Requirements

This application requires:

- Ruby 2.7.2
- PostgreSQL server

## Similar Projects

[Momofuku milk bar](http://milkbarstore.com/)
