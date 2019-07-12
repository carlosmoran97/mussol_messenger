
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messenger/User/model/user.dart';
import 'package:messenger/User/repository/user_repository.dart';

class UserBloc{
  final _userRepository = UserRepository();

  // Flujo de datos - Streams
  // Stream de Firebase, ya maneja una clase con Streams
  // Stream Controller
  Stream<FirebaseUser> _streamFirebase =
      FirebaseAuth.instance.onAuthStateChanged;
  Stream<FirebaseUser> get authStatus => _streamFirebase;
  Future<FirebaseUser> get currentUser => FirebaseAuth.instance.currentUser();

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
}

UserBloc userBloc = UserBloc();