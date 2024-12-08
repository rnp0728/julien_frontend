import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julien/core/utils/extensions/widget_extension.dart';
import 'package:julien/core/utils/forms/controller_manager.dart';
import 'package:julien/core/utils/forms/field_decorator.dart';
import 'package:julien/app/widget/builders/custom_grid_viewer.dart';
import 'package:julien/app/widget/buttons/primary_button.dart';
import 'package:julien/app/widget/texts/app_text.dart';
import 'package:julien/core/utils/extensions/context_extension.dart';
import 'package:julien/core/utils/validation/validator.dart';
import 'package:julien/presentation/onbaording/bloc/onbaording_bloc.dart';
import 'package:julien/presentation/onbaording/widgets/suggestion_text.dart';

class SigninContainer extends StatefulWidget {
  const SigninContainer({
    super.key,
    required OnbaordingBloc onbaordingBloc,
  }) : _onbaordingBloc = onbaordingBloc;

  final OnbaordingBloc _onbaordingBloc;

  @override
  State<SigninContainer> createState() => _SigninContainerState();
}

class _SigninContainerState extends State<SigninContainer> {
  late final ControllerManager ctrlManager;
  late final OnbaordingBloc onbaordingBloc;
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    onbaordingBloc = context.read<OnbaordingBloc>();
    _formKey = GlobalKey<FormState>();
    ctrlManager = ControllerManager()
      ..init([
        "email",
        "password",
      ]);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          elevation: 5,
          child: SizedBox(
            height: context.height * 0.5,
            width: context.responsive(
              context.width * 0.85,
              lg: context.width * 0.5,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(context.responsive(25, lg: 50)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        "Login to your Account",
                        fontSize: 24,
                      ),
                      _buildSigninFields(context),
                      PrimaryButton(
                        buttonText: "Sign In",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            onbaordingBloc.add(SigninEvent(
                              email: ctrlManager.get("email")!.text,
                              password: ctrlManager.get("password")!.text,
                            ));
                          }
                        },
                      ).centered(),
                    ].separator(20),
                  ),
                ),
                SuggestionText(
                  message: "Don't have an account?",
                  buttonText: "Sign up",
                  onButtonPressed: () {
                    widget._onbaordingBloc.add(ChangeOnbaordingModeEvent());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomGridViewer _buildSigninFields(BuildContext context) {
    return CustomGridViewer(
      gridData: const GridData(
        itemsPerRow: 1,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      children: [
        TextFormField(
          controller: ctrlManager.get("email")!,
          keyboardType: TextInputType.emailAddress,
          validator: Validator.email(),
          decoration: FieldDecorator(
            label: "Email Address",
            context: context,
          ),
        ),
        TextFormField(
          controller: ctrlManager.get("password")!,
          keyboardType: TextInputType.text,
          validator: Validator.password(),
          decoration: FieldDecorator(
            label: "Password",
            context: context,
          ),
          obscureText: true,
        ),
      ],
    );
  }
}
