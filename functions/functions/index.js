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

exports.addAnswer = functions.https.onRequest((request, response) => {
  var data = request.query;
  console.log("Data: ", data);
  admin.firestore().collection('answers').add({
      "productcategory": data.productcategory,
      "mood": data.mood,
      "timestamp": Date().toString(),
  }).then(writeResult => {
      response.send(writeResult, "\n", data);
      return;
  }).catch((error) => {
      response.send(error);
  });

})
