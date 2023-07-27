import 'dart:convert';

import 'package:feedback_view/custom_widgets/loading_indicator.dart';
import 'package:feedback_view/extras/validators.dart';
import 'package:feedback_view/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../extras/styles.dart';
import '../../services/storage_service.dart';

class LoginWidget extends StatefulWidget {
  final Function() changeToLogin;

  const LoginWidget({super.key, required this.changeToLogin});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String? errorText;
  bool loggingIn = false;
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  void removeSnackBar(){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  void login() async {
    if(loggingIn) return;
    removeSnackBar();
    String? etext =
        Validator.phoneNumberValidator(textEditingController.value.text);
    if (etext != null) {
      setState(() {
        errorText = etext;
      });
      return;
    }
    setState(() {
      loggingIn = true;
      errorText = null;
    });

    {
      // this block replicates user login
      http.Response response = await AuthService.service
          .vendorLogin(textEditingController.value.text);
      if (response.statusCode == 200) {
        Map<String,dynamic> data = jsonDecode(response.body);
        await StorageService.service.addKey(response.headers['auth-token']!);
        await StorageService.service.addCustomKey('logged', '1');
        await StorageService.service.addCustomKey('username', data['vendor_name']);
     //  await StorageService.service.addCustomKey('phone', '${data['vendor_phone_number']}');
        if(mounted) Navigator.of(context).popAndPushNamed('/database_view_page');
      }else {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response.headers['error']!)));
        }
      }
    }
    if (mounted) {
      setState(() {
        loggingIn = false;
        errorText = null;
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
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  errorText: errorText, labelText: 'phone number'),
              controller: textEditingController,
              maxLength: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: AppStyles.accessButtons,
                    child: (loggingIn)
                        ? const CustomLoadingIndicator()
                        : const Text('submit')),
                ElevatedButton(
                    onPressed: (loggingIn) ? null : widget.changeToLogin,
                    style: AppStyles.accessButtons,
                    child: const Text('sing up')),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
