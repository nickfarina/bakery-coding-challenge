---
name: 'Feature: cookies should actually be cooked'
about: 'Feature #4'
title: 'Feature: cookies should actually be cooked'
labels: ''
assignees: ''

---

We lazily added to Cookie: def ready?; true; end
But, the cookies are not actually ready instantly! When a cookie is placed in the oven, we need to trigger a background cooking worker to cook the cookies and update their state after a couple minutes of "cooking"
