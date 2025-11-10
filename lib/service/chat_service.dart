import 'package:chat_hive/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //========== get instance of firestore & Auth ===========
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //======== get user stream ====================
  //List<Map<String, dynamic>> =[
  // {
  // 'email': "user@gmail.com"
  // 'id' : '...'

  // }
  // {
  // 'email': "usenname@gmail.com"
  // 'id' : '...'
  // }
  //]

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snpshot) {
      return snpshot.docs.map((doc) {
        // go each indivisual user

        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  //============ send message ================
  Future<void> sendMessage(String reciverID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEmail,
      reciverID: reciverID,
      message: message,
      timestamp: timestamp,
    );
    // construct chat room ID for the two users (sorted to ensure uniwuenes)
    List<String> ids = [currentUserID, reciverID];
    ids.sort(); // sort the id this ensure the chatroom id is the same for any 2 people
    String chatRoomID = ids.join('_');

    // add new messaga to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // ===============get message =====================
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct a chatroom id for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
