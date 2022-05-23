import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/plass_snackbar_widget.dart';
import 'package:plass_getx/lib/src/data/models/user_model.dart';
import 'package:plass_getx/lib/src/data/repositories/auth_repository.dart';
import 'package:plass_getx/lib/src/data/services/auth_services.dart';
import 'package:plass_getx/lib/src/domain/repositories/i_auth_repository.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';

class RegisterController extends GetxController {
  final AuthenticateRepository _auth =
      AuthenticationImplementation(AuthenticateFirebase());

  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";

  RxBool loading = false.obs;
  RxBool view = false.obs;

  final formRegisterKey = GlobalKey<FormState>();

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

  String? firstNameUpdate(String? value) {
    firstName = value ?? "";
    return null;
  }

  String? lastNameUpdate(String? value) {
    lastName = value ?? "";
    return null;
  }

  void viewPasswordUpdate() {
    view.toggle();
  }

  ///Validate Form
  bool validateForm() {
    return formRegisterKey.currentState?.validate() ?? false;
  }

  Future<String?> registerUser() async {
    UserModel user = UserModel(
      lastName: lastName,
      firstName: firstName,
    );
    return _auth.createWithEmailAndPassword(
      email: email,
      password: password,
      user: user,
    );
  }

  Future<void> loginUser(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!validateForm()) {
      return;
    }
    loading.value = true;
    final result = await registerUser();

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
