import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:julien/presentation/onbaording/bloc/onbaording_bloc.dart';
import 'package:julien/presentation/onbaording/widgets/signin_container.dart';
import 'package:julien/presentation/onbaording/widgets/signup_container.dart';

class OnbaordingPage extends StatefulWidget {
  const OnbaordingPage({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => OnbaordingBloc(),
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
        listener: (context, state) {},
        builder: (context, state) {
          if (state is OnbaordingInitialState ||
              state is OnbaordingLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return state.onbaordingMode == OnbaordingMode.signup
              ? SignupContainer(onbaordingBloc: _onbaordingBloc)
              : SigninContainer(onbaordingBloc: _onbaordingBloc);
        },
      ),
    );
  }
}
