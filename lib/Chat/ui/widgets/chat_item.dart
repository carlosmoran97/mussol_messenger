import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Chat/model/chat.dart';
import 'package:messenger/Chat/ui/screens/chat_screen.dart';
import 'package:messenger/Message/model/message.dart';
import 'package:messenger/User/model/user.dart';

class ChatItem extends StatefulWidget {
  final Chat chat;
  final DocumentReference loggedUser;
  ChatItem({
    Key key,
    @required this.chat,
    @required this.loggedUser
  });
  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  User user;
  Message message;
  @override
  Widget build(BuildContext context) {

    var userFuture = widget.loggedUser.documentID == (widget.chat.users.first as DocumentReference).documentID ? widget.chat.users.last : widget.chat.users.first;

    return FutureBuilder<DocumentSnapshot>(
      future: userFuture.get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(!snapshot.hasData){
          return Container();
        }

        user = User(
          uid: snapshot.data.documentID,
          email: snapshot.data['email'],
          name: snapshot.data['name'],
          photoUrl: snapshot.data['photoUrl'],
          reference: snapshot.data.reference,
        );

        if(widget.chat.lastMessage == null){
          return Container();
        }

        return FutureBuilder<DocumentSnapshot>(
          future: widget.chat.lastMessage.get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if(!snapshot.hasData){
              return Container();
            }

            message = Message(
              dateSended: DateTime.fromMillisecondsSinceEpoch((snapshot.data['dateSended'] as Timestamp).millisecondsSinceEpoch),
              content: snapshot.data['content'],
              from: snapshot.data['from'],
              to: snapshot.data['to'],
              chat: snapshot.data['chat'],
            );

            return Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.chat.subject,
                    style: TextStyle(
                      color: Color(0xff0052ef),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${user.name}',
                        style: TextStyle(
                          color: Color(0xff20005a),
                        ),
                      ),
                      Text(
                        ' — ${message.content}',
                        style: TextStyle(
                            color: Color(0xff7155fa)
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ) ,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.photoUrl,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => ChatScreen(
                        chat: widget.chat,
                        peerName: user.name,
                        peerPhotoUrl: user.photoUrl,
                        id: widget.loggedUser,
                        peerId: user.reference,
                      )
                    ));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 64.0),
                  child: Divider(
                    color: Color(0xff7ffbde),
                  ),
                ),
              ],
            );
          }
        );
      }
    );
  }
}
