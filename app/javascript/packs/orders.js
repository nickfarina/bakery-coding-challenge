//= require cable
//= require_self
//= require_tree .

import React from "react"
import ReactDOM from "react-dom"
import { Orders } from "../orders/Orders"
import "whatwg-fetch"

document.addEventListener("turbolinks:load", () => {
  const element = document.querySelector("[data-order-table]")
  if (!element) return

  ReactDOM.render(<Orders />, element)
})

document.addEventListener("turbolinks:before-render", () => {
  const element = document.querySelector("[data-order-table]")
  if (element) ReactDOM.unmountComponentAtNode(element)
})

console.info("in ovens.js")
const App = {}

App.cable = ActionCable.createConsumer()

App.messages = App.cable.subscriptions.create("OvensChannel", {
  received: function (data) {
    console.info("got data??", data)
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
