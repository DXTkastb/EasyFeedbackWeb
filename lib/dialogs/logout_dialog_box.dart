import 'package:feedback_view/custom_widgets/loading_indicator.dart';
import 'package:feedback_view/services/storage_service.dart';
import 'package:flutter/material.dart';

import '../extras/styles.dart';

class LogoutDialogBox extends StatefulWidget {
  const LogoutDialogBox({super.key});

  @override
  State<LogoutDialogBox> createState() => _LogoutDialogBoxState();
}

class _LogoutDialogBoxState extends State<LogoutDialogBox> {
  bool loggingOut = false;
  void logout() async {
    if(loggingOut) return;
    setState(() {
      loggingOut = true;
    });

    await StorageService.service.removeKey();
    if(mounted) Navigator.of(context).pushNamedAndRemoveUntil('/login_signup_page', (route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder( borderRadius:  BorderRadius.circular(25)),
      actionsAlignment: MainAxisAlignment.center,
      content: const Text(
        'Are you sure?',
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: (loggingOut)
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          style: AppStyles.accessButtons,
          child: const Text('cancel'),
        ),
        ElevatedButton(
          onPressed: logout,
          style: AppStyles.accessButtons,
          child: (loggingOut)? const CustomLoadingIndicator() :const Text('logout'),
        ),
      ],
    );
  }
}
