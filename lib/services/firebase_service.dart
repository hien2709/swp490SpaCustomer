import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethod{

  createChatRoom(String chatRoomId, chatRoomMap) async{
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessage(String chatRoomId, messageMap) async{
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessage(String chatRoomId) async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRoomStream(int customerId)  async{
    await Firebase.initializeApp();
    return  await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: customerId)
        .snapshots();
  }

  getUserById(String id) async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: id)
        .get();
  }

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  uploadUserInfo(userInfoMap) async{
    FirebaseFirestore.instance.collection("users").add(userInfoMap);
  }

}