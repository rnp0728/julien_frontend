import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julien/core/di/dependency_injection.dart';
import 'package:julien/presentation/onbaording/bloc/onbaording_bloc.dart';
import 'package:julien/presentation/onbaording/widgets/signin_container.dart';
import 'package:julien/presentation/onbaording/widgets/signup_container.dart';
import 'package:julien/services/authentication/bloc/authentication_bloc.dart';
import 'package:julien/services/authentication/data/authentication_repository.dart';
import 'package:julien/services/initialization/widget/dependencies_scope.dart';

class OnbaordingPage extends StatefulWidget {
  const OnbaordingPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => OnbaordingBloc(
        authenticationRepository: getIt<AuthenticationRepository>(),
      )..add(OnbaordingInitEvent()),
      child: const OnbaordingPage(),
    );
  }

  @override
  State<OnbaordingPage> createState() => _OnbaordingPageState();
}

class _OnbaordingPageState extends State<OnbaordingPage> {
  late final OnbaordingBloc _onbaordingBloc;
  @override
  void initState() {
    super.initState();
    _onbaordingBloc = context.read<OnbaordingBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnbaordingBloc, OnbaordingState>(
        listener: (context, state) {
          if (state is OnbaordingSuccessState) {
            DependenciesScope.of(context).authBloc.add(SignInUserEvent(
                  context: context,
                  accessToken: state.responseData['accessToken'],
                  refreshToken: state.responseData['refreshToken'],
                  user: state.responseData['user'],
                ));
          }
        },
        builder: (context, state) {
          if (state is OnbaordingInitialState ||
              state is OnbaordingLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return AnimatedSize(
            duration: Durations.medium1,
            child: state.onbaordingMode == OnbaordingMode.signup
                ? SignupContainer(onbaordingBloc: _onbaordingBloc)
                : SigninContainer(onbaordingBloc: _onbaordingBloc),
          );
        },
      ),
    );
  }
}
