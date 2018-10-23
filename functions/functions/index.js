const functions = require('firebase-functions');
const admin = require('firebase-admin');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

admin.initializeApp({
  apiKey: 'AIzaSyCXQ0sr2Fd6URvQkHEIDeAOPbSejfx-F38',
  authDomain: 'geschmackssache-9a89b.firebaseapp.com',
  projectId: 'geschmackssache-9a89b'
});

// Initialize Cloud Firestore through Firebase
var db = admin.firestore();

// Disable deprecated features
db.settings({
  timestampsInSnapshots: true
});

exports.addSurvey = functions.https.onRequest((request, response) => {
  var body = JSON.parse(request.body);
  console.log("uuid: ", body.uuid);
  console.log("gender: ", body.gender);
  console.log("age: ", body.age);
  console.log("products: ", body.products);
  console.log("mood: ", body.mood);
  admin.firestore().collection('answers').add({
      "uuid": body.uuid,
      "gender": body.gender,
      "age": body.age,
      "products": body.products,
      "mood": body.mood,
      "timestamp": Date().toString(),
  }).then(writeResult => {
      response.send("OK");
      return;
  }).catch((error) => {
      response.send(error);
  });
})

exports.getSurvey = functions.https.onRequest((request, response) => {
  console.log("Getting survey collection");
  var result = {};
  var index = 0;
  admin.firestore().collection('answers').get().then(snapshot => {
    snapshot.forEach(doc => {
      var data = doc.data();
      console.log(doc.id, '=>', data);
      var elem = {
        "uuid": data.uuid,
        "gender": data.gender,
        "age": data.age,
        "mood": data.mood,
        "timestamp": data.timestamp,
      };
      console.log('JSON.parse() ', Date().toString());
      var products = JSON.parse(data.products);
      console.log('DONE!!! JSON.parse() ', Date().toString());
      // for (var x in products) {
      //     console.log('x = ', x);
      //     //elem[products[i].product] = products[i].state;
      // }
      for (i in products) {
        console.log(products[i]);
        // console.log(products[i].product);
        // console.log(products[i].state);
        elem[products[i].product] = products[i].state;
        console.log(elem);
      }
      //console.log("elem = ", elem);
      // var productsLength = Object.keys(products).length;
      // console.log("product.length = ", productsLength);
      // for (var i = 0; i < productsLength; i++) {
      //   console.log("product = ", products[i]);
      // }
      result[index] = elem;
      index++;
    })
    response.send(result);
    return;
  }).catch((error) => {
      response.send(error);
  });
})
