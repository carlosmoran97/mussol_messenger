import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/Chat/model/chat.dart';

class ChatApiProvider{
  final Firestore _db = Firestore.instance;
  void createFirebaseChat(Chat chat, String content){
    _db.collection('chats').add({
      'subject': chat.subject,
      'users': chat.users
    }).then((DocumentReference chatReference){
      _db.collection('messages').add({
        'dateSended': DateTime.now(),
        'from': chat.users.first,
        'to': chat.users.last,
        'content': content,
        'chat': chatReference
      }).then((DocumentReference messageReference){
        chatReference.updateData({
          'lastMessage': messageReference
        });
      });
    });
  }

  Stream<QuerySnapshot> getUserChats(DocumentReference userReference){
    return _db.collection('chats').where('users', arrayContains: userReference).snapshots();
  }

}