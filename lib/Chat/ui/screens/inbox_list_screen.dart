import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Chat/model/chat.dart';
import 'package:messenger/Chat/ui/widgets/bezier_fab.dart';
import 'package:messenger/Chat/ui/widgets/chat_item.dart';
import 'package:messenger/User/ui/screens/user_list.dart';
import 'package:messenger/widgets/messenger_app_bar.dart';
import 'package:messenger/widgets/messenger_drawer.dart';
import 'package:messenger/User/bloc/user_bloc.dart';
import 'package:messenger/Chat/bloc/chat_bloc.dart';


class InboxListScreen extends StatefulWidget {
  InboxListScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InboxListScreenState createState() => _InboxListScreenState();
}

class _InboxListScreenState extends State<InboxListScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.autorenew,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: MessengerDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 16.0,
        ),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async{
            String uid = (await userBloc.currentUser).uid;
            DocumentReference userReference = await userBloc.getCurrentUserReference(uid);
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context){
                return UserList(
                  uid: uid,
                  userReference: userReference
                );
              }
            ));
          },
          heroTag: null,
        ),
      ),
      body: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: BezierFab(
          iconData: Icons.inbox,
          onPressed: () {},
        ),
        bottomNavigationBar: MessengerAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody(){
    return  FutureBuilder<FirebaseUser>(
      future: userBloc.currentUser,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }


        return FutureBuilder<DocumentReference>(
          future: userBloc.getCurrentUserReference(snapshot.data.uid),
          builder: (BuildContext context, AsyncSnapshot<DocumentReference> snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            DocumentReference loggedUserId = snapshot.data;
            return StreamBuilder<QuerySnapshot>(
              stream: chatBloc.getUserChats(snapshot.data),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }

                return ListView(
                  children: snapshot.data.documents.reversed.toList().map((DocumentSnapshot ds){
                    Chat chat = Chat(
                      id: ds.documentID,
                      subject: ds['subject'],
                      lastMessage: ds['lastMessage'],
                      users: ds['users'],
                      reference: ds.reference,
                    );
                    return ChatItem(
                      chat: chat,
                      loggedUser: loggedUserId
                    );
                  }).toList(),
                );
              }
            );
          }
        );
      }
    );
  }

}