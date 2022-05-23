import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plass_getx/lib/src/core/hooks/curved_animation_hook.dart';
import 'package:plass_getx/lib/src/core/presentation/res/res.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/widgets.dart';
import 'package:plass_getx/lib/src/presentation/routes/routes.dart';

class SplashPage extends StatefulHookWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final _authentication = FirebaseAuth.instance;
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (_authentication.currentUser == null) {
          await Navigator.pushNamed(context, AppRoutes.login);
        } else {
          await Navigator.pushNamed(context, AppRoutes.home);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final animation = useCurvedAnimation(
      animationController,
      curve: Curves.bounceInOut,
    );

    useMemoized(() => Future<void>(animationController.forward));

    return SplashScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const VSpacing(5),
                AspectRatio(
                  aspectRatio: 2.5 / 1.1,
                  child: ScaleTransition(
                    scale: animation,
                    child: Image.asset(Assets.rickAndMortyLogo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
