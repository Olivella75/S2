/*Escriu una consulta per mostrar tots els documents en la col·lecció Restaurants.*/
db.restaurant.find();

/*Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine de tots els documents en la col·lecció Restaurants.*/
db.restaurant.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});

/*Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine, però excloent el camp _id per tots els documents en la col·lecció Restaurants.*/
db.restaurant.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0});

/*Escriu una consulta per mostrar restaurant_id, name, borough i zip code, però excloent el camp _id per tots els documents en la col·lecció Restaurants.*/
db.restaurant.find({}, {restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1, _id: 0});

/*Escriu una consulta per mostrar tots els restaurants que estan en el Bronx.*/
db.restaurant.find({borough: "Bronx"});

/*Escriu una consulta per mostrar els primers 5 restaurants que estan en el Bronx.*/
db.restaurant.find({borough: "Bronx"}).limit(5);

/*Escriu una consulta per mostrar els 5 restaurants després de saltar els primers 5 que siguin del Bronx.*/
db.restaurant.find({borough: "Bronx"}).skip(5).limit(5);

/*Escriu una consulta per trobar els restaurants que tenen algun score més gran de 90.*/
db.restaurant.find({"grades.score": {$gt: 90}});

/*Escriu una consulta per trobar els restaurants que tenen un score més gran que 80 però menys que 100.*/
db.restaurant.find({grades: {$elemMatch: {score: {$gt: 80, $lt: 100}}}});

/*Escriu una consulta per trobar els restaurants que estan situats en una longitud inferior a -95.754168.*/
db.restaurant.find({"address.coord": {$lt: -95.754168}});

/*Escriu una consulta de MongoDB per a trobar els restaurants que no cuinen menjar 'American ' i tenen algun score superior a 70 i longitud inferior a -65.754168.*/
db.restaurant.find({$and: [{cuisine: {$ne: "American"}}, {"grades.score": {$gt: 70}}, {"address.coord": {$lt: -65.754168}}]});

/*Escriu una consulta per trobar els restaurants que no preparen menjar 'American' i tenen algun score superior a 70 i que, a més, es localitzen en longituds inferiors a -65.754168. Nota: Fes aquesta consulta sense utilitzar operador $and.*/
db.restaurant.find({cuisine: {$ne: "American"}, "grades.score": {$gt: 70}, "address.coord": {$lt: -65.754168}});

/*Escriu una consulta per trobar els restaurants que no preparen menjar 'American ', tenen alguna nota 'A' i no pertanyen a Brooklyn. S'ha de mostrar el document segons la cuisine en ordre descendent.*/
db.restaurant.find({cuisine: {$ne: "American"}, "grades.grade": "A", borough: {$ne: "Brooklyn"}}).sort({cuisine: -1});

/*Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Wil' en les tres primeres lletres en el seu nom.*/
db.restaurant.find({name: {$regex: /^Wil/}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});

/*Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'ces' en les últimes tres lletres en el seu nom.*/
db.restaurant.find({name: {$regex: /ces$/}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});

/*Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Reg' en qualsevol lloc del seu nom.*/
db.restaurant.find({name: {$regex: /Reg/}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});

/*Escriu una consulta per trobar els restaurants que pertanyen al Bronx i preparen plats Americans o xinesos.*/
db.restaurant.find({$and: [{borough: "Bronx"}, {$or: [{cuisine: "American"}, {cuisine: "Chinese"}]}]});

/*Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per aquells restaurants que pertanyen a Staten Island, Queens, Bronx o Brooklyn.*/
db.restaurant.find({$or: [{borough: "Staten Island"}, {borough: "Queens"}, {borough: "Bronx"}, {borough: "Brooklyn"}]}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});

/*Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que NO pertanyen a Staten Island, Queens, Bronx o Brooklyn.*/
db.restaurant.find({borough: {$nin: ["Staten Island", "Queens", "Bronx", "Brooklyn"]}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});

/*Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que aconsegueixin una nota menor que 10.*/
db.restaurant.find({"grades.score": {$lt: 10}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1});

/*Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que preparen marisc ('seafood') excepte si són 'American ', 'Chinese' o el name del restaurant comença amb lletres 'Wil'.*/
db.restaurant.find({$and: [{cuisine: "Seafood"}, {name: {$not: /^Will/}}]}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0});

/*Escriu una consulta per trobar el restaurant_id, name i grades per a aquells restaurants que aconsegueixin un grade de "A" i un score d'11 amb un ISODate "2014-08-11T00:00:00Z".*/
db.restaurant.find({$and: [{"grades.grade": "A"}, {"grades.score": 11}, {"grades.date": new Date("2014-08-11T00:00:00Z")}]}, {restaurant_id: 1, name: 1, grades: 1});

/*Escriu una consulta per trobar el restaurant_id, name i grades per a aquells restaurants on el 2n element de l'array de graus conté un grade de "A" i un score 9 amb un ISODate "2014-08-11T00:00:00Z".*/
db.restaurant.find({$and: [{"grades.1.grade": "A"}, {"grades.score": 11}, {"grades.date": new Date("2014-08-11T00:00:00Z")}]}, {restaurant_id: 1, name: 1, grades: 1});

/*Escriu una consulta per trobar el restaurant_id, name, adreça i ubicació geogràfica per a aquells restaurants on el segon element de l'array coord conté un valor entre 42 i 52.*/
db.restaurant.find({"address.coord.1": {$gt: 42, $lt: 52}}, {restaurant_id: 1, name: 1, address: 1});

/*Escriu una consulta per organitzar els restaurants per nom en ordre ascendent.*/
db.restaurant.find({}, {name: 1}).sort({name: 1});

/*Escriu una consulta per organitzar els restaurants per nom en ordre descendent.*/
db.restaurant.find({}, {name: 1}).sort({name: -1});

/*Escriu una consulta per organitzar els restaurants pel nom de la cuisine en ordre ascendent i pel barri en ordre descendent.*/
db.restaurant.find({}, {cuisine: 1}).sort({cuisine: 1, borough: -1});

/*Escriu una consulta per saber si les direccions contenen el carrer.*/
db.restaurant.find({"address.street": {$exists: true}});

/*Escriu una consulta que seleccioni tots els documents en la col·lecció de restaurants on els valors del camp coord és de tipus Double.*/
db.restaurant.find({"address.coord": {$type: "double"}});

/*Escriu una consulta que seleccioni el restaurant_id, name i grade per a aquells restaurants que retornen 0 com a residu després de dividir algun dels seus score per 7.*/
db.restaurant.find({"grades.score" : {$mod: [7, 0]}}, {restaurant_id: 1, name: 1, grades: 1});

/*Escriu una consulta per trobar el name de restaurant, borough, longitud, latitud i cuisine per a aquells restaurants que contenen 'mon' en algun lloc del seu name.*/
db.restaurant.find({name: {$regex: /mon/}}, {name: 1, borough: 1, "address.coord": 1, cuisine: 1});

/*Escriu una consulta per trobar el name de restaurant, borough, longitud, latitud i cuisine per a aquells restaurants que contenen 'Mad' com a primeres tres lletres del seu name.*/
db.restaurant.find({name: {$regex: /^Mad/}}, {name: 1, borough: 1, coord: 1, cuisine: 1});