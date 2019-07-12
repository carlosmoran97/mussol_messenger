import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/User/bloc/user_bloc.dart';
import 'package:messenger/User/model/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Continue with Google'),
                onPressed: (){
                  userBloc.signOut();
                  userBloc.signIn().then((FirebaseUser user){
                    userBloc.updateUserData(User(
                      email: user.email,
                      photoUrl: user.photoUrl,
                      name: user.displayName,
                      uid: user.uid,
                    ));
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
