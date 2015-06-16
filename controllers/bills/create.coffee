'use strict'

_ = require('lodash')
bills_db = require('../../models/bills_db')
purchases_db = require('../../models/purchases_db')
products_db = require('../../models/products_db')
shops_db = require('../../models/shops_db')
io = require('../io')

module.exports = (req, response, next) ->
  processSaving = (bill, absent_products)->
    counter = 0
    if absent_products > 0
      _.each bill.purchases, (item, k)->
        if !item.product_id
          products_db.save {title: item.title}, (err, res)->
            item.product_id = res.id

            counter++
            if counter is absent_products
              saveBill(bill)
    else
      saveBill(bill)



  saveBill = (bill)->
    purchases_db.save bill.purchases, (err, res) ->
      bill.purchases = []
      _.each res, (v)->
        bill.purchases.push v.id

      bills_db.save bill, (err, res) ->
        io.show('чек из ' + bill.shop_title + ' от ' + bill.date + ' успешно создан', 'success')
        response.body = {success:true, id: res.id}
        next()
        return
      return
    return

  saveShop = (bill, cb)->
    if bill.shop_title
      if !bill.shop_id
        shops_db.save {title: bill.shop_title}, (err, res)->
          bill.shop_id = res.id
          cb()
      else
        cb()
    else

    return

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
      if bill.shop_title
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
      else
        io.show('Не указан магазин', 'error')
        response.body = {success: false, message: 'Не указан магазин'}
  else
    io.show('Пользователь не зарегистрирован', 'error')
    response.body = {success: false, message: 'Пользователь не зарегистрирован'}

  return
