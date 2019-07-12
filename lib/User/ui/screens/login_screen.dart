import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
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
          FlareActor(
            'assets/Background.flr',
            alignment: Alignment.bottomCenter,
            shouldClip: false,
            fit: BoxFit.cover,
            animation: 'Background loop',
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 180,
                  width: 180,
                  padding: EdgeInsets.all(16),
                  child: FlareActor(
                    'assets/New User.flr',
                    alignment: Alignment.bottomCenter,
                    shouldClip: false,
                    fit: BoxFit.cover,
                    animation: 'Astronaut charging',
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xDDFFFFFF)
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.10,
                    vertical: 8.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'USER NAME or EMAIL',
                      hintStyle: TextStyle(
                        color: Color(0xaaffffff),
                      )
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.10,
                    right: MediaQuery.of(context).size.width * 0.10,
                    top: 8.0,
                    bottom: 16.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'PASSWORD',
                        hintStyle: TextStyle(
                          color: Color(0xaaffffff),
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RawMaterialButton(
                    shape: StadiumBorder(),
                    fillColor: Color(0xff00f8bd),
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 48.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      userBloc.signOut();
                      userBloc.signIn().then((FirebaseUser user) {
                        userBloc.updateUserData(User(
                          email: user.email,
                          photoUrl: user.photoUrl,
                          name: user.displayName,
                          uid: user.uid,
                        ));
                      });
                    },
                  ),
                ),
                RawMaterialButton(
                  shape: StadiumBorder(),
                  fillColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Continue with ',
                        style: TextStyle(
                          color: Color(0xff7f7f7f)
                        ),
                      ),
                      Image.asset(
                        'assets/google_icon.png',
                        width: 24.0,
                        height: 24.0,
                        color: Color(0xff7f7f7f),
                      ),
                    ],
                  ),
                  onPressed: () {
                    userBloc.signOut();
                    userBloc.signIn().then((FirebaseUser user) {
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
          ),
        ],
      ),
    );
  }
}
