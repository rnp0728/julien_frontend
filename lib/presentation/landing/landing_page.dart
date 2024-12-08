import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:julien/core/utils/extensions/context_extension.dart';
import 'package:julien/core/utils/extensions/widget_extension.dart';
import 'package:julien/core/utils/persistent_manager.dart';
import 'package:julien/app/widget/texts/app_text.dart';
import 'package:julien/services/initialization/model/app_colors.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Seamless Data Migration with Julien",
              style: TextStyle(fontSize: 36),
              textAlign: TextAlign.center,
            ),
            10.spacer(),
            const Text(
              "Effortlessly transfer collections between DB instances(as of now only MongoDB). Julien simplifies the migration process with efficient, secure, and reliable tools, ensuring your data moves smoothly without any hassle.",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            20.spacer(),
            ElevatedButton.icon(
              onPressed: () {
                PersistentManager.setBool(
                  "visitedLandingPage",
                  true,
                );
                context.go("/onbaording");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    context.isLightTheme ? AppColors.yellow : AppColors.blue,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
              ),
              label: AppText(
                "Get Started",
                fontSize: 20,
                color: context.isLightTheme ? AppColors.black : AppColors.white,
              ),
              icon: Icon(
                Icons.arrow_circle_right_outlined,
                color: context.isLightTheme ? AppColors.black : AppColors.white,
              ),
              iconAlignment: IconAlignment.end,
            ),
          ],
        ),
      ),
    );
  }
}
