import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:plass_getx/lib/src/presentation/forgot/forgot_binding.dart';
import 'package:plass_getx/lib/src/presentation/forgot/forgot_page.dart';
import 'package:plass_getx/lib/src/presentation/home/home_binding.dart';
import 'package:plass_getx/lib/src/presentation/home/home_page.dart';
import 'package:plass_getx/lib/src/presentation/login/login_binding.dart';
import 'package:plass_getx/lib/src/presentation/login/login_page.dart';
import 'package:plass_getx/lib/src/presentation/register/register_binding.dart';
import 'package:plass_getx/lib/src/presentation/register/register_page.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';
import 'package:plass_getx/lib/src/presentation/splash/splash_binding.dart';
import 'package:plass_getx/lib/src/presentation/splash/splash_page.dart';

class AppPages {
  static final List<GetPage> pages = [

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => const ForgotPage(),
      binding: ForgotBinding(),
    ),
  ];
}
