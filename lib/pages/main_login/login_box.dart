import '/services/network_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final void Function(String name, int id) loginFunction;

  const Login({Key? key, required this.loginFunction}) : super(key: key);

  @override
  State<Login> createState() => _LoginBox();
}

class _LoginBox extends State<Login> {
  late TextEditingController textEditingController;
  bool loading = false;
  String? credentials;
  bool isvalid = true;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  bool isValidText(String input) {
    bool match = RegExp(r'^\d+$').hasMatch(input);
    match = input.contains(RegExp(r'[1-9]')) && match;
    return !match;
  }

  Future<void> invokeLogin() async {
    String input = textEditingController.value.text;
    if (isValidText(input)) {
      setState(() {
        isvalid = false;
      });
      return;
    }
    setState(() {
      isvalid = true;
      loading = true;
      credentials = null;
    });
    int vendorId = int.parse(input);
    var userLoggedInData = await NetworkApi.authUser(vendorId);
    if (userLoggedInData != null) {
      await (await SharedPreferences.getInstance())
          .setInt("vendorID", vendorId);
      if (mounted) {
        setState(() {
          loading = false;
          credentials = null;
        });
        widget.loginFunction(userLoggedInData.name, userLoggedInData.id);
      }
    } else {
      if (mounted) {
        setState(() {
          loading = false;
          credentials = "Vendor does not exists!";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          maxLength: 12,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              errorText: (isvalid) ? null : "Only numbers allowed!",
              labelText: "VENDOR ID",
              labelStyle: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              helperText: credentials,
              helperStyle:
                  const TextStyle(fontSize: 11, color: Colors.redAccent)),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          autofocus: true,
          controller: textEditingController,
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: invokeLogin,
            child: (loading)
                ? const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text("LOGIN")),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text("OR"),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/signup");
            },
            child: const Text("SIGN UP"))
      ],
    );
  }
}
