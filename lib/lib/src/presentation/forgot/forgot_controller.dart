import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plass_getx/lib/src/data/repositories/auth_repository.dart';
import 'package:plass_getx/lib/src/data/services/auth_services.dart';
import 'package:plass_getx/lib/src/domain/repositories/i_auth_repository.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';

class ForgotController extends GetxController {
  final AuthenticateRepository _auth =
      AuthenticationImplementation(AuthenticateFirebase());

  String email = "";

  RxBool loading = false.obs;
  RxBool view = false.obs;

  final formForgotKey = GlobalKey<FormState>();

  //Update Name
  String? emailUpdate(String? value) {
    email = value ?? "";
    return null;
  }

  Future<void> recoveryPassword(BuildContext context) async {
    final result = await _auth.recoveryPassword(email);

    if (result != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
      return null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Correo de recuperación enviado con éxito'),
        ),
      );
      Future.delayed(
        const Duration(seconds: 2),
        () async {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
        },
      );
      return;
    }
  }
}
