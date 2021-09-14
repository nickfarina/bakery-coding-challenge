// @ts-check
import React, { useEffect, useState } from "react"
import { OrderTable } from "./OrderTable"

export const Orders = () => {
  const [orders, setOrders] = useState([])

  useEffect(() => {
    const go = async () => {
      try {
        const orders = await fetchOrders()
        setOrders(orders)
      } catch (er) {
        alert(`uh oh! ${er}`)
      }
    }
    go()
  }, [])

  return <OrderTable orders={orders} />
}

const fetchOrders = async () => {
  const response = await fetch("/api/orders.json")
  const data = await response.json()
  return data
}
