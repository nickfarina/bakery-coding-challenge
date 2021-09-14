---
name: 'Feature: As a bakery owner, I should see the oven page update automatically
  when the cookies are ready'
about: 'Feature #3'
title: 'Feature: As a bakery owner, I should see the oven page update automatically
  when the cookies are ready'
labels: ''
assignees: ''

---

Given I have unfinished cookies in an oven
And I am on the oven page
Then I should see that the cookies are not yet ready
When the cookies finish cooking
Then I should see that the cookies are ready

Note: This can be non-instant (e.g. performed through periodic polling is acceptable), but only the relevant part of the page should update
