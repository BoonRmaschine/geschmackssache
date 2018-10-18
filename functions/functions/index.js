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
