const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const firestore = admin.firestore();
const fcm = admin.messaging();

// Cloud Firestore triggers ref: https://firebase.google.com/docs/functions/firestore-events
exports.newChatMessageNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {

    const receiver = snapshot.data()["receiverId"];

    // Selected fcm tokens
    const fcm_tokens_snapshots = await firestore
    .collection('users')
    .doc(receiver)
    .collection("tokens")
    .get();

    const fcm_tokens = fcm_tokens_snapshots.docs.map(snap => snap.id);

    if (fcm_tokens == null || fcm_tokens.length == 0) {
      console.log('No tokens to send message to!');
      return;
    }

    // Notification message.
    const message = {
      notification: {
        title: snapshot.data()["senderName"],
        body: snapshot.data()["message"],
        clickAction: "FLUTTER_NOTIFICATION_CLICK"
      },
      tokens: fcm_tokens
    };

    // Return this function's promise, so this ensures the firebase function
    // will keep running, until the notification is scheduled.
    return await fcm.sendEachForMulticast(message);
  });