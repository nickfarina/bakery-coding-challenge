// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

;(function () {
  this.App || (this.App = {})

  App.cable = ActionCable.createConsumer()

  App.messages = App.cable.subscriptions.create("OvensChannel", {
    received: function (data) {
      switch (data.message) {
        case "COOKIES_READY":
          document
            .querySelector(`.retrieve-section[data-oven-id="${data.oven_id}"]`)
            .classList.add("ready")
          return
        default:
          return
      }
    },
  })
}.call(this))
