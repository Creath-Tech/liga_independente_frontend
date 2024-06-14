import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService userService = UserService();

  AuthService(this._firebaseAuth);

  Future<Either<FirebaseAuthException, UserCredential>> signIn(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return Right(userCredential);
    } on FirebaseAuthException catch (_) {
      return Left(_);
    }
  }

  Future<Either<FirebaseAuthException, bool>> recoveryPassword(
        String email) async {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);

        return const Right(true);
      } on FirebaseAuthException catch (_) {
        return Left(_);
      }
   }
  
  Future<Either<FirebaseAuthException, UserCredential>> signUp(String email, String password, String name) async {
    try{
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);  
      userCredential.user!.updateDisplayName(name);

      UserModel userModel = UserModel(
        userId: userCredential.user!.uid,
        email: email, 
        name: name,
        bio: '',
        sports: [],
        contacts: {}
        );

      setUser(userModel);
      userService.updateUser(userModel);

      return Right(userCredential);
    } on FirebaseAuthException catch (_) {
      return Left(_);
    }
  }


  void setUser(UserModel userModel) async{
    await _firestore
    .collection('users')
    .doc(userModel.userId)
    .set(userModel.toJson());
  }

  Stream<QuerySnapshot> getUsers() {
    return _firestore.collection('users').snapshots();
  }
}
