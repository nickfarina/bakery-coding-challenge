// @ts-check
import React, { useEffect, useState } from "react"

export const OrderTable = ({ orders }) => {
  const [sortProperty, setSortProperty] = useState({
    attribute: "",
    ascending: true,
  })

  const sortBy = (attribute) => {
    if (sortProperty.attribute === attribute) {
      setSortProperty({
        attribute,
        ascending: !sortProperty.ascending,
      })
    } else {
      setSortProperty({ attribute, ascending: true })
    }
  }

  const orderSortFn = (a, b) => {
    if (!sortProperty.attribute) {
      return 1
    }

    if (a[sortProperty.attribute] > b[sortProperty.attribute]) {
      return sortProperty.ascending ? 1 : -1
    } else {
      return sortProperty.ascending ? -1 : 1
    }
  }

  return (
    <table className="table orders-table">
      <thead>
        <tr>
          <th className="sortable" onClick={() => sortBy("id")}>
            Order #
          </th>
          <th>Ordered at</th>
          <th className="sortable" onClick={() => sortBy("pick_up_at")}>
            Pick up at
          </th>
          <th className="sortable" onClick={() => sortBy("customer_name")}>
            Customer Name
          </th>
          <th>Item</th>
          <th>Qty</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        {orders.sort(orderSortFn).map((order) => (
          <OrderRow order={order} />
        ))}
      </tbody>
    </table>
  )
}

const OrderRow = ({ order }) => {
  return (
    <tr>
      <td>{order.id}</td>
      <td>{formatDate(order.created_at)}</td>
      <td>{formatDate(order.pick_up_at)}</td>
      <td>{order.customer_name}</td>
      <td>{order.item}</td>
      <td>{order.quantity}</td>
      <td>{order.fulfilled ? `Fulfilled` : `In progress`}</td>
      <td></td>
    </tr>
  )
}

const formatDate = (dateString) => {
  let date = new Date(dateString)
  return date.toLocaleDateString()
}
