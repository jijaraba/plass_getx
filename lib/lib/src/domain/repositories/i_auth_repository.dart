import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plass_getx/lib/src/data/models/user_model.dart';

abstract class AuthenticateRepository {
  Future<String?> createWithEmailAndPassword({
    required String email,
    required String password,
    required UserModel user,
  });

  ///Login
  Future<String?> loginWithEmailAndPassword(String email, String password);

  ///Recovery Password
  Future<String?> recoveryPassword(String email);


  ///Get User Info
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo();

  ///LogOut
  Future<String?> signOut();
}
