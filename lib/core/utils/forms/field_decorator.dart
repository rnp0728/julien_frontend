import 'package:flutter/material.dart';
import 'package:julien/core/utils/extensions/context_extension.dart';
import 'package:julien/services/initialization/model/app_colors.dart';

class FieldDecorator extends InputDecoration {
  FieldDecorator({
    required String label,
    required BuildContext context,
    EdgeInsets? contentPadding,
    bool isDropdown = false,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) : super(
          label: isDropdown
              ? null
              : Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.start,
                ),
          labelText: isDropdown ? label : null,
          labelStyle: TextStyle(
            color: context.byTheme(
              light: AppColors.black.withOpacity(0.6),
              dark: AppColors.white.withOpacity(0.6),
            ),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          hintMaxLines: 1,
          hintTextDirection: TextDirection.ltr,
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          alignLabelWithHint: true,
          floatingLabelBehavior:
              isDropdown ? floatingLabelBehavior : FloatingLabelBehavior.auto,
          contentPadding:
              contentPadding ?? const EdgeInsets.fromLTRB(12, 8, 12, 8),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: context.byTheme(
                light: AppColors.black.withOpacity(0.3),
                dark: AppColors.white.withOpacity(0.3),
              ),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: context.byTheme(
                light: AppColors.black,
                dark: AppColors.white,
              ),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: context.byTheme(
                light: AppColors.red,
                dark: AppColors.red,
              ),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: context.byTheme(
                light: AppColors.red,
                dark: AppColors.red,
              ),
              width: 2,
            ),
          ),
          suffixIcon: isDropdown
              ? Icon(
                  Icons.keyboard_arrow_down,
                  size: 28,
                  weight: 20,
                  color: context.byTheme(
                    light: AppColors.black,
                    dark: AppColors.white,
                  ),
                )
              : const SizedBox.shrink(),
        );
}
