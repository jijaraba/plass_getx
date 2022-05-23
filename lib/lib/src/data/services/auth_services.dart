import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plass_getx/lib/src/data/models/user_model.dart';

class AuthenticateFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Login
  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Email not exist.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password.';
      }
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  ///Recovery Password
  Future<String?> recoveryPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      return 'Email not exist';
    }
    return null;
  }

  ///Register User
  Future<String?> createWithEmailAndPassword({
    required String email,
    required String password,
    required UserModel user,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _db.collection('users').doc(email).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'Ya existe una cuenta asociada a la dirección de correo electrónico, intente de nuevo con una nueva cuenta.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  ///Get User Info
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() {
    return _db
        .collection('users')
        .doc(_auth.currentUser!.email)
        .snapshots();
  }

  ///SignOut
  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return e.toString();
    }
    return null;
  }
}
