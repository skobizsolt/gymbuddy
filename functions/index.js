const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const firestore = admin.firestore();
const fcm = admin.messaging();

// Cloud Firestore triggers ref: https://firebase.google.com/docs/functions/firestore-events
exports.newChatMessageNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate((snapshot, context) => {

    // TODO: get targets fcm token
    const target = firestore
    .collection('users')
    .doc(snapshot.data()["receiverId"])
    .collection("tokens")
    .get();

    const tokens = target.docs.map(snap => snap.id);

    // Return this function's promise, so this ensures the firebase function
    // will keep running, until the notification is scheduled.
    return fcm.sendToDevice(tokens, {
      // Sending a notification message.
      notification: {
        title: snapshot.data()["senderName"],
        body: snapshot.data()["message"],
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });