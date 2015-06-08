'use strict'

_ = require('lodash')
bills_db = require('../../models/bills_db')
purchases_db = require('../../models/purchases_db')
products_db = require('../../models/products_db')
shops_db = require('../../models/shops_db')

module.exports = (req, res, next) ->
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
      if bill.shop_title and !bill.shop_id
        saveShop bill, ()->
          absent_products = 0
          for i in [0..body.title.length]
            item =
              creation_date: bill.creation_date
              creator: req.user._id
              shop: req.body.shop
              shop_id: bill.shop_id
              date: req.body.date
              title: req.body.title[i]
              product_id: req.body.product_id[i]
              price: req.body.price[i]
              measure: req.body.measure[i]
              count: req.body.count[i]
              sum: req.body.sum[i]

            if item.title
              bill.purchases.push item
              if !item.product_id
                absent_products++
          if bill.purchases.length > 0
            processSaving(bill, absent_products)

  next()
  return

saveShop = (bill, cb)->
  shops_db.shops.save {title: bill.shop_title}, (err, res)->
    bill.shop_id = res.id
    cb()
  return

processSaving = (bill, absent_products)->
  counter = 0
  if absent_products > 0
    _.each bill.purchases, (item, k)->
      if !item.product_id
        products_db.products.save {title: item.title}, (err, res)->
          item.product_id = res.id

          counter++
          if counter is absent_products
            saveBill(bill)
  else
    saveBill(bill)



saveBill = (bill)->
  purchases_db.purchases.save bill.purchases, (err, res) ->
    bill.purchases = []
    _.each res, (v)->
      bill.purchases.push v.id

    bills_db.bills.save bill, (err, res) ->
      # Handle response
      return
    return
  return


#savePurchase = (purchase, count, bill)->
#  saveToDb = ()->
#    purchases_db.purchases.save purchase, (err, res) ->
#      console.log res
#      bill.purchases.push res.id
#
#      if bill.purchases.length is count   # and count > 0
#        saveBill(bill)
#      # Handle response
#      return
#
#  console.log purchase
#  if purchase.title
#    if !purchase.product_id
#      products_db.products.save {title: purchase.title}, (err, res) ->
#        purchase.id = res.id
#        saveToDb()
#    else
#      saveToDb()
#
#  return