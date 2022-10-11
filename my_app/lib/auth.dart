import 'package:firebase_auth/firebase_auth.dart';

class Auth {
 // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseAuth auth;
  Auth({required this.auth});
  User? get currentUser => this.auth.currentUser;

  Stream<User?> get authStateChanges => this.auth.authStateChanges();

  Future<void> sendPasswordResetEmail({
    required String mail,
  }) async {
    await this.auth.sendPasswordResetEmail(email: mail);
  }

  Future<void> signInWithEmailAndPassword({
    required String mail,
    required String mdp,
  }) async {
    await this.auth.signInWithEmailAndPassword(
      email: mail,
      password: mdp,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String mail,
    required String mdp,
  }) async {
    await this.auth.createUserWithEmailAndPassword(
      email: mail,
      password: mdp,
    );
  }

  Future<void> signOut() async {
    await this.auth.signOut();
  }
}
