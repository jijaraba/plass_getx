import 'package:flutter/cupertino.dart';

class TouchableOpacity extends StatelessWidget {
  const TouchableOpacity({
    Key? key,
    required this.onPressed,
    required this.child,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      child: child,
    );
  }
}
