---
name: 'Feature: Sorting order listing table'
about: 'Feature #5'
title: 'Feature: Sorting order listing table'
labels: ''
assignees: ''

---

Given there are orders in the system

When I visit the orders page
Then I should see "Order #", "Customer Name" and "Pick up at" column headers underlined, signifying that i can click on the header to sort the column

When I click on a sortable column header
Then the data in the table is reordered by that particular column in ascending order
