
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/User/model/user.dart';
import 'package:messenger/User/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc{
  final _userRepository = UserRepository();

  // Flujo de datos - Streams
  // Stream de Firebase, ya maneja una clase con Streams
  // Stream Controller
  Stream<FirebaseUser> _streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => _streamFirebase;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();
  PublishSubject<List<User>> _userFetcher = PublishSubject<List<User>>();

  Observable<List<User>> get users => _userFetcher.stream;

  //Casos de uso
  //1. signIn a la aplicación de Google
  // El nombre debe de ser genérico
  Future<FirebaseUser> signIn() {
    return _userRepository.signInFirebase();
  }

  //2. Cerrar sesión
  signOut() {
    _userRepository.signOut();
  }

  // Registrar la tabla users
  void updateUserData(User user){
    return _userRepository.updateUserData(user);
  }

  // Devolver la lista de usuarios

  void fetchUsers(String uid){
    _userRepository.getCloudFirestoreUsers().listen((QuerySnapshot snapshot){
      List<User> users = List<User>();
      for(DocumentSnapshot ds in snapshot.documents){

        if(ds.data["uid"] != uid){
          User user = User(
            uid: ds.data["uid"],
            name: ds.data["name"],
            email: ds.data["email"],
            photoUrl: ds.data["photoUrl"],
            reference: ds.reference
          );
          users.add(user);
        }
      }
      _userFetcher.sink.add(users);
    });
  }

  Future<DocumentReference> getCurrentUserReference(String uid){
    return _userRepository.getCurrentUserReference(uid);
  }

  void dispose(){
    _userFetcher.close();
  }

}

UserBloc userBloc = UserBloc();