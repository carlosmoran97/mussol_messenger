import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/Chat/model/chat.dart';
import 'package:messenger/Chat/repository/chat_repository.dart';

class ChatBloc{
  final _chatRepository = ChatRepository();

  void createFirebaseChat(Chat chat, String content) => _chatRepository.createFirebaseChat(chat, content);
  Stream<QuerySnapshot> getUserChats(DocumentReference userReference) => _chatRepository.getUserChats(userReference);
}

ChatBloc chatBloc = ChatBloc();