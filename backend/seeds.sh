#!/bin/sh

###################################################
# Bash script to create database and seed 
###################################################

var mongoose = require("mongoose");


var Item = mongoose.model("Item");
var Comment = mongoose.model("Comment");
var User = mongoose.model("User");

var auth = require("../auth");

const { sendEvent } = require("../../lib/event");

#Crear 100 usuarios 

for (var i = 0; i < 5; i++) {
  var user = new User();

  user.username = "User"+i;
  user.email = "user"+i+"@email.com";
  user.setPassword("user"+i+(i*7));

  user
    .save()
    .then(function() {
      #sendEvent('user_created', { username: "User"+i })
      #Crear 100 items
      User.findById(user.toAuthJSON())
        .then(function(user) {
        if (!user) {
            return res.sendStatus(401);
        }

        var item = new Item();

        item.title = "Item"+i;
        item.description = "Item description "+i;
        item.image = "https://scontent.fvlc2-1.fna.fbcdn.net/v/t39.30808-6/307156556_411810111040040_3717411444934014865_n.png?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=k8F1trL81sgAX-jNiBY&_nc_ht=scontent.fvlc2-1.fna&oh=00_AfCCmiJ_1OjaEoMv7w98OOgzaZm1Ax7Ri9fwovxOHRcK5w&oe=63DE4691";
        item.slug = "dataseeding-quest-item-7zkivu"+i;
        item.seller = user;

        return item.save().then(function() {
            #sendEvent('item_created', { item: item })
        });
        })
    });
};


#Crear 100 comentarios