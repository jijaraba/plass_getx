import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plass_getx/lib/src/core/presentation/res/res.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/custom_text_field.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/widgets.dart';
import 'package:plass_getx/lib/src/core/utils/validator/validator_form.dart';
import 'package:plass_getx/lib/src/presentation/login/login_controller.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScaffold(body: GetBuilder<LoginController>(
      builder: (controller) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: UIColors.black16,
          child: Stack(children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 600,
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: controller.formKey,
                      child: Center(
                        child: Column(
                          children: [
                            const VSpacing(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  Assets.logoWhite,
                                  height: 50,
                                ),
                              ],
                            ),
                            const VSpacing(50),
                            CustomTextFieldLogin(
                              validator: ValidatorForm.validatorEmail,
                              hintText: 'Email',
                              type: TextInputType.emailAddress,
                              text: controller.emailUpdate,
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              return CustomTextFieldLogin(
                                validator: ValidatorForm.validatorPassword,
                                hintText: 'Password',
                                type: TextInputType.emailAddress,
                                viewPassword: !controller.view.value,
                                eye: true,
                                text: controller.passwordUpdate,
                                callback: controller.viewPasswordUpdate,
                              );
                            }),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Olvidaste tu contraseña?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => controller.loading.value
                                      ? null
                                      : Navigator.pushNamed(
                                          context, AppRoutes.forgot),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Obx(
                              () {
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                  child: controller.loading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              UIColors.green100,
                                            ),
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            CupertinoButton(
                                              child: controller.loading.value
                                                  ? const CircularProgressIndicator()
                                                  : const Text(
                                                      'Ingresar ahora',
                                                      style: TextStyle(
                                                        color:
                                                            UIColors.green100,
                                                      ),
                                                    ),
                                              color: Colors.white,
                                              onPressed: () =>
                                                  controller.loginUser(context),
                                            ),
                                          ],
                                        ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: CupertinoButton(
                                    color: UIColors.green100,
                                    child: const Text(
                                      'Registrarse',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                        context,
                                        AppRoutes.register,
                                      );
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    ));
  }
}
