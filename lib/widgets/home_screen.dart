import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Chat/ui/screens/inbox_list_screen.dart';
import 'package:messenger/User/bloc/user_bloc.dart';
import 'package:messenger/User/ui/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userBloc.authStatus,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
        if(!snapshot.hasData){
          return LoginScreen();
        }

        return InboxListScreen();

      },
    );
  }
}
