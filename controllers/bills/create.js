// Generated by CoffeeScript 1.9.1
(function() {
  'use strict';
  var _, bills_db, processSaving, products_db, purchases_db, saveBill, saveShop, shops_db;

  _ = require('lodash');

  bills_db = require('../../models/bills_db');

  purchases_db = require('../../models/purchases_db');

  products_db = require('../../models/products_db');

  shops_db = require('../../models/shops_db');

  module.exports = function(req, res, next) {
    var bill, body;
    if (req.user) {
      body = req.body;
      bill = {
        shop_title: req.body.shop,
        shop_id: req.body.shop_id,
        date: req.body.date,
        creator: req.user._id,
        buyer: "common",
        creation_date: new Date(),
        purchases: []
      };
      if (Array.isArray(body.title) && body.title.length > 0) {
        if (bill.shop_title && !bill.shop_id) {
          saveShop(bill, function() {
            var absent_products, i, item, j, ref;
            absent_products = 0;
            for (i = j = 0, ref = body.title.length; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
              item = {
                creation_date: bill.creation_date,
                creator: req.user._id,
                shop: req.body.shop,
                shop_id: bill.shop_id,
                date: req.body.date,
                title: req.body.title[i],
                product_id: req.body.product_id[i],
                price: req.body.price[i],
                measure: req.body.measure[i],
                count: req.body.count[i],
                sum: req.body.sum[i]
              };
              if (item.title) {
                bill.purchases.push(item);
                if (!item.product_id) {
                  absent_products++;
                }
              }
            }
            if (bill.purchases.length > 0) {
              return processSaving(bill, absent_products);
            }
          });
        }
      }
    }
    next();
  };

  saveShop = function(bill, cb) {
    shops_db.shops.save({
      title: bill.shop_title
    }, function(err, res) {
      bill.shop_id = res.id;
      return cb();
    });
  };

  processSaving = function(bill, absent_products) {
    var counter;
    counter = 0;
    if (absent_products > 0) {
      return _.each(bill.purchases, function(item, k) {
        if (!item.product_id) {
          return products_db.products.save({
            title: item.title
          }, function(err, res) {
            item.product_id = res.id;
            counter++;
            if (counter === absent_products) {
              return saveBill(bill);
            }
          });
        }
      });
    } else {
      return saveBill(bill);
    }
  };

  saveBill = function(bill) {
    purchases_db.purchases.save(bill.purchases, function(err, res) {
      bill.purchases = [];
      _.each(res, function(v) {
        return bill.purchases.push(v.id);
      });
      bills_db.bills.save(bill, function(err, res) {});
    });
  };

}).call(this);
