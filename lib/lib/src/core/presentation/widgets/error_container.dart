import 'package:flutter/material.dart';
import 'package:plass_getx/lib/src/core/presentation/res/res.dart';
import 'package:plass_getx/lib/src/core/presentation/theme/theme.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/custom_button.dart';
import 'package:plass_getx/lib/src/core/presentation/widgets/widgets.dart';
import 'package:plass_getx/lib/src/core/utils/commons_extensions.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({
    Key? key,
    required this.text,
    this.subtitle,
    this.textColor = Colors.black,
    this.onRetryPress,
  }) : super(key: key);

  final String text;
  final String? subtitle;
  final Color textColor;
  final VoidCallback? onRetryPress;

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              children: [
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                VSpacing(20),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: textNormal.copyWith(color: UIColors.black),
                  ),
                VSpacing(20),
                CustomButton(
                  paddingHorizontal: 90,
                  onPressed: () {

                  },
                  text: localization.text('common.removeFilters'),
                  textColor: UIColors.white,
                )
              ],
            ),
          ),
          IconButton(
            onPressed: onRetryPress,
            icon: const Icon(Icons.refresh, size: 28),
          ),
        ],
      ),
    );
  }
}
