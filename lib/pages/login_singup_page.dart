import 'package:feedback_view/pages/signup/singup_widget.dart';
import 'package:flutter/material.dart';

import 'login/login_widget.dart';

class LoginSignUpPage extends StatelessWidget {
  const LoginSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: DualPageView());
  }
}

class DualPageView extends StatefulWidget {
  const DualPageView({super.key});

  @override
  State<DualPageView> createState() => _DualPageViewState();
}

class _DualPageViewState extends State<DualPageView> {
  // 0 => log in
  // 1 => sign up
  bool toggle = false;

  void changeView() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = (toggle)
        ? SignUpWidget(
            changeToLogin: changeView,
          )
        : LoginWidget(
            changeToLogin: changeView,
          );

    return Center(

      child: SizedBox(
        width: 300,
        child: AnimatedSwitcher(
          transitionBuilder: (wid,animation) {
            return FadeTransition(opacity: animation,child: wid,);
          },
            duration: const Duration(milliseconds: 350), child: child),
      ),
    );

  }
}
