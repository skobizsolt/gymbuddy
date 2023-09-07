const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Cloud Firestore triggers ref: https://firebase.google.com/docs/functions/firestore-events
exports.newChatMessageNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate((snapshot, context) => {
    // Return this function's promise, so this ensures the firebase function
    // will keep running, until the notification is scheduled.
    return admin.messaging().sendToTopic("chats", {
      // Sending a notification message.
      notification: {
        title: snapshot.data()["senderName"],
        body: snapshot.data()["message"],
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    });
  });