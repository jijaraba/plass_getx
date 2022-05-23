import 'package:flutter/material.dart';
import 'package:plass_getx/lib/src/core/presentation/res/res.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/touchable_opacity.dart';

class ShinyIconButton extends StatelessWidget {
  const ShinyIconButton({
    Key? key,
    required this.icon,
    this.color = UIColors.darkBlue,
    this.iconColor = UIColors.white,
    this.shadowColor = UIColors.white,
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  final Color color;
  final Color iconColor;
  final Color shadowColor;
  final double? width;
  final double? height;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: color,
          shape: const CircleBorder(),
          shadows: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 1,
              color: shadowColor,
            ),
          ],
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: ShinyCirclePainter(),
            child: Center(
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShinyCirclePainter extends CustomPainter {
  ShinyCirclePainter({
    this.diff = 10,
    this.top = 2,
  });

  final double diff, top;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = (size.width - diff) / 2;
    final center = Offset(size.width / 2, radius + top);
    final paint = Paint()..color = UIColors.white.withOpacity(0.11);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(ShinyCirclePainter oldDelegate) =>
      diff != oldDelegate.diff || top != oldDelegate.top;
}
