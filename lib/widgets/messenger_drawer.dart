import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/User/bloc/user_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessengerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          FutureBuilder(
            future: userBloc.currentUser,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              return DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                            style: BorderStyle.solid
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            snapshot.data.photoUrl,
                          ),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Text(
                      snapshot.data.displayName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      snapshot.data.email,
                      style: TextStyle(
                        color: Color(0xAAFFFFFF),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
            ),
            title: Text('Cerrar sesión'),
            onTap: (){
              Navigator.pop(context);
              userBloc.signOut();
            },
          ),
          Divider()
        ],
      ),
    );
  }
}
