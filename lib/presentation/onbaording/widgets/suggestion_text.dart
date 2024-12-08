import 'package:flutter/material.dart';
import 'package:julien/core/utils/extensions/widget_extension.dart';
import 'package:julien/app/widget/texts/app_text.dart';
import 'package:julien/services/initialization/model/app_colors.dart';

class SuggestionText extends StatelessWidget {
  final String message;
  final String buttonText;
  final void Function() onButtonPressed;
  const SuggestionText({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(message),
            5.spacer(),
            InkWell(
              onTap: onButtonPressed,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: AppText(
                buttonText,
                color: AppColors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
