import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Chat/ui/screens/create_chat_form.dart';
import 'package:messenger/User/bloc/user_bloc.dart';
import 'package:messenger/User/model/user.dart';

class UserList extends StatefulWidget {
  final String uid;
  final DocumentReference userReference;
  UserList({
    Key key,
    this.uid,
    this.userReference,
  });
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void didChangeDependencies() {
    userBloc.fetchUsers(widget.uid);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuarios'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
      stream: userBloc.users,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data.map((User user) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl),
                  ),
                  title: Text(user.name),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateChatForm(
                          users: [widget.userReference ,user.reference],
                        );
                      },
                    );
                  },
                ),
                Divider(),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
