import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectAppBar extends StatefulWidget {
  const ProjectAppBar({super.key});

  @override
  State<ProjectAppBar> createState() => _ProjectAppBarState();
}

class _ProjectAppBarState extends State<ProjectAppBar> {
  @override
  Widget build(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Text("Julien"),
    );
  }
}
