
import 'package:flutter/material.dart';
import 'package:julien/core/utils/extensions/context_extension.dart';
import 'package:julien/core/utils/extensions/widget_extension.dart';
import 'package:julien/core/widget/texts/app_text.dart';
import 'package:julien/presentation/onbaording/bloc/onbaording_bloc.dart';
import 'package:julien/services/initialization/model/app_colors.dart';

class SigninContainer extends StatelessWidget {
  const SigninContainer({
    super.key,
    required OnbaordingBloc onbaordingBloc,
  }) : _onbaordingBloc = onbaordingBloc;

  final OnbaordingBloc _onbaordingBloc;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
          elevation: 5,
          child: SizedBox(
            height: context.height * 0.6,
            width: context.width * 0.6,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 50.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        "Login to your Account",
                        fontSize: 24,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const AppText("Don't have an account?"),
                        5.spacer(),
                        InkWell(
                          onTap: () {
                            _onbaordingBloc
                                .add(ChangeOnbaordingModeEvent());
                          },
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: AppText(
                            "Sign up",
                            color: AppColors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
