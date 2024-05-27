import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

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
}
