import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/Chat/model/chat.dart';
import 'package:messenger/Chat/repository/chat_api_provider.dart';

class ChatRepository{
  final _chatApiProvider = ChatApiProvider();
  void createFirebaseChat(Chat chat, String content) => _chatApiProvider.createFirebaseChat(chat, content);
  Stream<QuerySnapshot> getUserChats(DocumentReference userReference) => _chatApiProvider.getUserChats(userReference);
}