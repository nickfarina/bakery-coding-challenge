---
name: 'Feature #2'
about: 'Feature: Add loading indicator for Order Listing'
title: 'Feature: Add loading indicator for Order Listing'
labels: ''
assignees: ''

---

Given there are orders in the system
When I visit the orders page
Then I should see a loading indicator that signifies that order data is being fetched
When the data has finished loading
Then I see the order listing
