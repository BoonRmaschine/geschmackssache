const functions = require('firebase-functions');
const admin = require('firebase-admin');
const Json2csvParser = require('json2csv').Parser;

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
  console.log("Getting survey");
  var result = [];
  admin.firestore().collection('answers').get().then(snapshot => {
    snapshot.forEach(doc => {
      var data = doc.data();
      var elem = {
        "uuid": data.uuid,
        "gender": data.gender,
        "age": data.age,
        "mood": data.mood,
        "timestamp": data.timestamp,
      };
      // We need to parse the nested JSON string here,
      // because the app has a bug which can't be fixed that easy
      var products = JSON.parse(data.products);
      for (i in products) {
        elem[products[i].product] = products[i].state;
      }
      result.push(elem);
    })
    // Collecting keys
    var keys = [];
    for (var key in result[0]) {
      keys.push(key);
    }
    // Converting JSON to CSV
    const json2csvParser = new Json2csvParser({ keys, delimiter: ';', eol: '</br>' });
    const csv = json2csvParser.parse(result);

    // Returning survey as CSV
    response.send(csv);
    return;
  }).catch((error) => {
      response.send(error);
  });
})
