// @ts-check
import React, { useState } from "react"
import Skeleton, { SkeletonTheme } from "react-loading-skeleton"

const columnWidths = [111, 147, 136, 265, 313, 66, 144, 111]

export const OrderTable = ({ orders }) => (
  <table className="table orders-table">
    <thead>
      <tr>
        <th>Order #</th>
        <th>Ordered at</th>
        <th>Pick up at</th>
        <th>Customer Name</th>
        <th>Item</th>
        <th>Qty</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      {orders.map((order) => (
        <OrderRow order={order} key={order.id} />
      ))}
    </tbody>
  </table>
)

const OrderRow = (props) => {
  const [order, setOrder] = useState(props.order)
  const [fulfillSubmissions, setFulfillSubmissions] = useState({})

  const fulfillOrder = async (order) => {
    setFulfillSubmissions({ ...fulfillSubmissions, [order.id]: true })

    const response = await fetch(`/api/orders/${order.id}/fulfill`, {
      method: "put",
    })
    const data = await response.json()

    setOrder(data)
  }

  const fulfillButtonDisabled = (order) => fulfillSubmissions[order.id]

  return (
    <tr>
      <td>{order.id}</td>
      <td>{formatDate(order.created_at)}</td>
      <td>{formatDate(order.pick_up_at)}</td>
      <td>{order.customer_name}</td>
      <td>{order.item}</td>
      <td>{order.quantity}</td>
      <td>{order.fulfilled ? `Fulfilled` : `In progress`}</td>
      <td>
        {!order.fulfilled && (
          <button
            onClick={() => {
              fulfillOrder(order)
            }}
            disabled={fulfillButtonDisabled(order)}
          >
            Fulfill order
          </button>
        )}
      </td>
    </tr>
  )
}

const LoadingRows = () => {
  return (
    <>
      {[...Array(5)].map((_, rowNumber) => {
        let skeletonElement = <Skeleton />

        if (rowNumber % 2 !== 0) {
          skeletonElement = (
            <SkeletonTheme
              color="#fff"
              highlightColor="#f5f5f5"
              children={<Skeleton />}
            />
          )
        }

        return (
          <tr>
            {columnWidths.map((width) => (
              <td width={width}>{skeletonElement}</td>
            ))}
          </tr>
        )
      })}
    </>
  )
}

const formatDate = (dateString) => {
  let date = new Date(dateString)
  return date.toLocaleDateString()
}
