const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const firestore = admin.firestore();

// Cloud Firestore triggers ref: https://firebase.google.com/docs/functions/firestore-events
exports.newChatMessageNotification = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate(async (snapshot, context) => {

    const messageData = snapshot.data();
    const receiver = messageData["receiverId"];
    functions.logger.log("New message sent by user: " + receiver);
    functions.logger.debug("Title: " + messageData["senderName"]);
    functions.logger.debug("Message: " + messageData["message"]);

    // Selected fcm tokens
    return await firestore
    .collection('users')
    .doc(receiver)
    .collection("tokens")
    .get()
    .then(
      result => {

        fcm_tokens = [];
        result.docs.forEach(
          document => {
            fcm_tokens.push(document.id);
          }
        );

        // Checking if tokens available
        if (fcm_tokens == null || fcm_tokens.length == 0) {
          functions.logger.debug('No tokens to send message to!');
          return;
        }

        // Sending messages
        functions.logger.debug('Tokens found, tokens: ' + fcm_tokens);
        admin.messaging().sendEachForMulticast(
          {
            tokens: fcm_tokens,
            notification: {
              title: messageData["senderName"],
              body: messageData["message"]
            }
          }
        );
      }
    );
});