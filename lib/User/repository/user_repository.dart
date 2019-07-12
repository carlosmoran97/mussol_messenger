import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/User/model/user.dart';
import 'package:messenger/User/repository/user_api_provider.dart';

class UserRepository{
  final UserApiProvider _userApiProvider = UserApiProvider();
  Future<FirebaseUser> signInFirebase() => _userApiProvider.signIn();
  signOut() => _userApiProvider.signOut();
  void updateUserData(User user){
    return _userApiProvider.updateUserData(user);
  }
  Stream<QuerySnapshot> getCloudFirestoreUsers() => _userApiProvider.getCloudFirestoreUsers();
  Future<DocumentReference> getCurrentUserReference(String uid) => _userApiProvider.getCurrentUserReference(uid);
}