import 'dart:convert';

import 'package:feedback_view/extras/styles.dart';
import 'package:feedback_view/services/auth_service.dart';
import 'package:feedback_view/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../custom_widgets/loading_indicator.dart';
import '../../extras/validators.dart';

class SignUpWidget extends StatefulWidget {
  final Function() changeToLogin;

  const SignUpWidget({super.key, required this.changeToLogin});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  String? phoneErrorText;
  String? upiErrorText;
  String? usernameErrorText;

  bool loggingIn = false;
  late final TextEditingController usernameEditingController;
  late final TextEditingController phoneNumberEditingController;
  late final TextEditingController upiEditingController;

  @override
  void initState() {
    super.initState();
    usernameEditingController = TextEditingController();
    phoneNumberEditingController = TextEditingController();
    upiEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    usernameEditingController.dispose();
    phoneNumberEditingController.dispose();
    upiEditingController.dispose();
  }

  void removeSnackBar(){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  void login() async {
    if(loggingIn) return;
    removeSnackBar();
    String? phoneNumError =
        Validator.phoneNumberValidator(phoneNumberEditingController.value.text);
    String? upiError = Validator.upiValidator(upiEditingController.value.text);
    String? usernameError =
        Validator.usernameValidator(usernameEditingController.value.text);
    if (phoneNumError != null || upiError != null || usernameError != null) {
      setState(() {
        phoneErrorText = phoneNumError;
        upiErrorText = upiError;
        usernameErrorText = usernameError;
      });
      return;
    }
    setState(() {
      loggingIn = true;
      phoneErrorText = null;
      upiErrorText = null;
      usernameErrorText = null;
    });

    {
      // this block replicates user login
      http.Response response = await AuthService.service.createVendor(
          usernameEditingController.value.text,
          phoneNumberEditingController.value.text,
          upiEditingController.value.text);

      if (response.statusCode == 200) {
        Map<String,dynamic> data = jsonDecode(response.body);
        await StorageService.service.addKey(response.headers['auth-token']!);
        await StorageService.service.addCustomKey('logged', '1');
        await StorageService.service.addCustomKey('username', data['vendor_name']);
       // await StorageService.service.addCustomKey('phone', '${data['vendor_phone_number']}');
        if(mounted) Navigator.of(context).popAndPushNamed('/database_view_page');
      }
      else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response.headers['error']!)));
        }
      }
    }
    if (mounted) {
      setState(() {
        loggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 30,
      color: const Color.fromRGBO(241, 227, 255, 1.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: usernameErrorText, labelText: 'username'),
              controller: usernameEditingController,
              maxLength: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLength: 100,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(errorText: upiErrorText, labelText: 'upi id'),
              controller: upiEditingController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: phoneErrorText, labelText: 'phone number'),
              controller: phoneNumberEditingController,
              maxLength: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: login,
                    style: AppStyles.accessButtons,
                    child: (loggingIn)
                        ? const CustomLoadingIndicator()
                        : const Text('submit')),
                ElevatedButton(
                  onPressed: (loggingIn) ? null : (){
                    removeSnackBar();
                    widget.changeToLogin();
                  },
                  style: AppStyles.accessButtons,
                  child: const Text('login'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
