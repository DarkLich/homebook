'use strict'

bills_db = require('../../models/bills_db')
purchases_db = require('../../models/purchases_db')
products_db = require('../../models/products_db')

module.exports = (req, res, next) ->
  console.log 'CREATION'
  console.log(req.body)
  if req.user
    body = req.body
    bill =
      shop_title: req.body.shop
      shop_id: req.body.shop_id
      date: req.body.date
      creator: req.user._id
      buyer: "common"
      creation_date: new Date()
      purchases: []
    if Array.isArray(body.title) and body.title.length > 0
      empty_items_count = 0
      for i in [0..body.title.length]
        item =
          creation_date: bill.creation_date
          creator: req.user._id
          shop: req.body.shop
          date: req.body.date
          title: req.body.title[i]
          product_id: req.body.product_id[i]
          price: req.body.price[i]
          measure: req.body.measure[i]
          count: req.body.count[i]
          sum: req.body.sum[i]

        if !item.title
          empty_items_count++

        savePurchase(item, body.title.length - empty_items_count, bill)
#    else
#      item =
#        creation_date: bill.creation_date
#        creator: req.user._id
#        shop: req.body.shop
#        date: req.body.date
#        title: req.body.title
#        price: req.body.price
#        measure: req.body.measure
#        count: req.body.count
#        sum: req.body.sum
#
#      savePurchase(item, 1, bill)

  next()
  return

savePurchase = (purchase, count, bill)->
  saveToDb = ()->
    purchases_db.purchases.save purchase, (err, res) ->
      console.log res
      bill.purchases.push res.id

      if bill.purchases.length is count   # and count > 0
        saveBill(bill)
      # Handle response
      return

  console.log purchase
  if purchase.title
    if !purchase.product_id
      products_db.products.save {title: purchase.title}, (err, res) ->
        purchase.id = res.id
        saveToDb()
    else
      saveToDb()

  return


saveBill = (bill)->
  bills_db.bills.save bill, (err, res) ->
    # Handle response
    return