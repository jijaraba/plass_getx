import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/plass_snackbar_widget.dart';
import 'package:plass_getx/lib/src/data/repositories/auth_repository.dart';
import 'package:plass_getx/lib/src/data/services/auth_services.dart';
import 'package:plass_getx/lib/src/domain/repositories/i_auth_repository.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';

class LoginController extends GetxController {
  final AuthenticateRepository _auth =
      AuthenticationImplementation(AuthenticateFirebase());

  String email = "";
  String password = "";

  RxBool loading = false.obs;
  RxBool view = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    loading.close();
    view.close();
    super.dispose();
  }

  //Update Name
  String? emailUpdate(String? value) {
    email = value ?? "";
    return null;
  }

  String? passwordUpdate(String? value) {
    password = value ?? "";
    return null;
  }

  void viewPasswordUpdate() {
    view.toggle();
  }

  ///Validate Form
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> loginWithEmailAndPassword() {
    return _auth.loginWithEmailAndPassword(email, password);
  }

  Future<void> loginUser(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!validateForm()) {
      return;
    }
    loading.value = true;
    final result = await loginWithEmailAndPassword();
    if (result == null) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.home, (route) => false);
      return;
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        PlassSnackbarWidget.snackbarInfo(result),
      );
    }
    loading.value = false;
  }
}
