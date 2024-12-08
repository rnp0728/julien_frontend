import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julien/core/utils/extensions/context_extension.dart';
import 'package:julien/core/utils/extensions/widget_extension.dart';
import 'package:julien/core/utils/forms/controller_manager.dart';
import 'package:julien/app/widget/builders/custom_grid_viewer.dart';
import 'package:julien/core/utils/forms/field_decorator.dart';
import 'package:julien/app/widget/buttons/primary_button.dart';
import 'package:julien/app/widget/texts/app_text.dart';
import 'package:julien/core/utils/validation/validator.dart';
import 'package:julien/presentation/onbaording/bloc/onbaording_bloc.dart';
import 'package:julien/presentation/onbaording/widgets/suggestion_text.dart';

class SignupContainer extends StatefulWidget {
  const SignupContainer({
    super.key,
    required OnbaordingBloc onbaordingBloc,
  }) : _onbaordingBloc = onbaordingBloc;

  final OnbaordingBloc _onbaordingBloc;

  @override
  State<SignupContainer> createState() => _SignupContainerState();
}

class _SignupContainerState extends State<SignupContainer> {
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
        "organisation",
        "name",
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
            height: context.height * 0.6,
            width: context.responsive(
              context.width * 0.85,
              lg: context.width * 0.5,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(context.responsive(25, lg: 50)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        "Create an Account",
                        fontSize: 24,
                      ),
                      _buildFormFields(context),
                      PrimaryButton(
                        buttonText: "Sign Up",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            onbaordingBloc.add(SignupEvent(
                              organisation:
                                  ctrlManager.get("organisation")!.text,
                              name: ctrlManager.get("name")!.text,
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
                  message: "Already have an account?",
                  buttonText: "Sign in",
                  onButtonPressed: () {
                    widget._onbaordingBloc.add(ChangeOnbaordingModeEvent());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomGridViewer _buildFormFields(BuildContext context) {
    return CustomGridViewer(
      gridData: const GridData(
        itemsPerRow: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children: [
        TextFormField(
          controller: ctrlManager.get("organisation"),
          validator: Validator.empty(),
          decoration: FieldDecorator(
            label: "Organisation",
            context: context,
          ),
        ),
        TextFormField(
          controller: ctrlManager.get("name"),
          validator: Validator.empty(),
          decoration: FieldDecorator(
            label: "Name",
            context: context,
          ),
        ),
        TextFormField(
          controller: ctrlManager.get("email"),
          validator: Validator.email(),
          decoration: FieldDecorator(
            label: "Email Address",
            context: context,
          ),
        ),
        TextFormField(
          controller: ctrlManager.get("password"),
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
