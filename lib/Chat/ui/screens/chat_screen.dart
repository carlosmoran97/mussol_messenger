import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Chat/model/chat.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  final String peerName;
  final String peerPhotoUrl;
  final DocumentReference peerId;
  final DocumentReference id;
  ChatScreen(
      {Key key,
      @required this.chat,
      @required this.peerName,
      @required this.peerPhotoUrl,
      @required this.id,
      @required this.peerId});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var listMessage;

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.peerName,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Row(
          children: <Widget>[
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.peerPhotoUrl,
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          FlareActor(
            'assets/Background.flr',
            alignment: Alignment.bottomCenter,
            shouldClip: false,
            fit: BoxFit.cover,
            animation: 'Background loop',
          ),
          Column(
            children: <Widget>[
              // List of messages
              Flexible(
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('messages')
                      .where('chat', isEqualTo: widget.chat.reference)
                      .orderBy('dateSended', descending: true)
                      .limit(20)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor)));
                    } else {
                      listMessage = snapshot.data.documents;
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) =>
                            buildItem(index, snapshot.data.documents[index]),
                        itemCount: snapshot.data.documents.length,
                        reverse: true,
                        controller: listScrollController,
                      );
                    }
                  },
                ),
              ),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          //buildLoading()
        ],
      ),
    );
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      Firestore.instance.collection('messages').add({
        'dateSended': DateTime.now(),
        'from': widget.id,
        'to': widget.peerId,
        'content': content,
        'chat': widget.chat.reference
      }).then((DocumentReference messageReference) {
        widget.chat.reference
            .updateData({'lastMessage': messageReference}).then((ref) {
          listScrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        });
      });
    } else {}
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          SizedBox(
            width: 8.0,
          ),
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: Theme.of(context).primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['from'].documentID == widget.id.documentID) {
      // Right (my message)
      return Row(
        children: <Widget>[
          Container(
            child: Text(
              '${document['content']}',
              style: TextStyle(color: Colors.black),
            ),
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            width: 200.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffa467fa),
                      offset: Offset(1.0, 1.0),
                      blurRadius: 5.0)
                ]),
            margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    '${document['content']}',
                    style: TextStyle(color: Colors.black),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffa467fa),
                          offset: Offset(1.0, 1.0),
                          blurRadius: 5.0)
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10.0),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }
}
