import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();  

  Future<void> sendPasswordResetEmail({
    required String mail,
  }) async {
    await _firebaseAuth.sendPasswordResetEmail(email: mail);
  }

  Future<void> signInWithEmailAndPassword({
    required String mail,
    required String mdp,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: mail,
      password: mdp,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String mail,
    required String mdp,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: mail,
      password: mdp,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}