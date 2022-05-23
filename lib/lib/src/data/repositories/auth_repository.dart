import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plass_getx/lib/src/data/models/user_model.dart';
import 'package:plass_getx/lib/src/data/services/auth_services.dart';
import 'package:plass_getx/lib/src/domain/repositories/i_auth_repository.dart';

class AuthenticationImplementation implements AuthenticateRepository {
  final AuthenticateFirebase authenticationFirebase;

  AuthenticationImplementation(this.authenticationFirebase);

  @override
  Future<String?> signOut() {
    return authenticationFirebase.signOut();
  }

  @override
  Future<String?> loginWithEmailAndPassword(String email, String password) {
    return authenticationFirebase.loginWithEmailAndPassword(email, password);
  }

  @override
  Future<String?> recoveryPassword(String email) {
    return authenticationFirebase.recoveryPassword(email);
  }

  @override
  Future<String?> createWithEmailAndPassword({
    required String email,
    required String password,
    required UserModel user,
  }) {
    return authenticationFirebase.createWithEmailAndPassword(
      email: email,
      password: password,
      user: user,
    );
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo() {
    return authenticationFirebase.getUserInfo();
  }
}
