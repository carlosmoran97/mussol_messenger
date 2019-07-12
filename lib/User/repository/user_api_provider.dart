import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger/User/model/user.dart';

class UserApiProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;
    FirebaseUser user =
    await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
      idToken: gSA.idToken,
      accessToken: gSA.accessToken,
    ));



    return user;
  }

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    return await ref.setData({
      'uid': user.uid,
      'name': user.name,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'lastSignIn': DateTime.now()
    }, merge: true);
  }

  void signOut() async{
    await _auth.signOut().then((onValue) => print("Sesión cerrada"));
    googleSignIn.signOut();
  }
}