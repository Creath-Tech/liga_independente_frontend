import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:liga_independente_frontend/src/models/user_model.dart';
import 'package:liga_independente_frontend/src/services/location_service.dart';
import 'package:liga_independente_frontend/src/services/user_service.dart';
// Future<Either<FirebaseAuthException, UserCredential>>
//     signInWithGoogle() async {
//   try {
//     final googleUser = await GoogleSignIn().signIn();
//     final googleAuth = await googleUser?.authentication;
//     final userCredential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

//     var userUid = userCredential.idToken.toString();
//     var userModel = await getUser(userUid);

//     locationService.getCurrentLocation().then(
//         (position) => locationService.saveUserLocation(position, userUid));

//     userService.updateUser(userModel);
//     return Right(
//         await FirebaseAuth.instance.signInWithCredential(userCredential));
//   } on FirebaseAuthException catch (_) {
//     return Left(_);
//   }
// }

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService userService = UserService.instance;
  final LocationService locationService = LocationService();

  AuthService(this._firebaseAuth);

  Future<Either<FirebaseAuthException, UserCredential>> signIn(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      var userUid = userCredential.user!.uid;
      var userModel = await getUser(userUid);

      locationService.getCurrentLocation().then(
          (position) => locationService.saveUserLocation(position, userUid));

      userService.updateUser(userModel);
      return Right(userCredential);
    } on FirebaseAuthException catch (_) {
      return Left(_);
    }
  }

  Future<Either<FirebaseAuthException, UserCredential>>
      signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      UserModel userModel = UserModel(
          userId: userCredential.user!.uid,
          email: googleUser?.email,
          name: googleUser?.displayName,
          bio: '',
          sports: [],
          contacts: {});

      getUser(userCredential.user!.uid).onError(
        (error, stackTrace) {
          setUser(userModel);
        },
      );

      userService.updateUser(userModel);
      locationService.getCurrentLocation().then((position) =>
          locationService.saveUserLocation(position, userModel.userId!));

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

  Future<Either<FirebaseAuthException, UserCredential>> signUp(
      String email, String password, String name) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      userCredential.user!.updateDisplayName(name);

      UserModel userModel = UserModel(
          userId: userCredential.user!.uid,
          email: email,
          name: name,
          bio: '',
          sports: [],
          contacts: {});

      userService.updateUser(userModel);
      setUser(userModel);

      locationService.getCurrentLocation().then((position) =>
          locationService.saveUserLocation(position, userModel.userId!));

      return Right(userCredential);
    } on FirebaseAuthException catch (_) {
      return Left(_);
    }
  }

  void setUser(UserModel userModel) async {
    await _firestore
        .collection('users')
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  Stream<QuerySnapshot> getUsers() {
    return _firestore.collection('users').snapshots();
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('userId', isEqualTo: userId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var userData = snapshot.docs.first.data() as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      }
      throw FirebaseAuthException(code: 'auth-not-found-in-users-colection');
    } catch (e) {
      rethrow;
    }
  }

  void loggout() {
    _firebaseAuth.signOut();
  }
}
