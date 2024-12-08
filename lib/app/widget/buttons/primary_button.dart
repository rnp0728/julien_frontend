import 'package:flutter/material.dart';
import 'package:julien/core/utils/extensions/context_extension.dart';
import 'package:julien/app/widget/texts/app_text.dart';
import 'package:julien/services/initialization/model/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            context.isLightTheme ? AppColors.yellow : AppColors.blue,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
      ),
      child: AppText(
        buttonText,
        fontSize: 18,
        color: context.isLightTheme ? AppColors.black : AppColors.white,
      ),
    );
  }
}
