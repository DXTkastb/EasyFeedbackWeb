import 'package:feedback_view/services/network_api.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Feedback"),
      ),
      body: const Center(
          child: SizedBox(height: 300, width: 300, child: SignUp())),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController textEditingController;
  late TextEditingController numberEditingController;
  bool isValidName = true;
  bool isValidNumber = true;
  bool? signing = false;
  int? newID;
  int errorOccured = 0;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    numberEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    newID = null;
    super.dispose();
  }

  bool validateText(String text, bool isnum) {
    if (!isnum) {
      text = text.toLowerCase();
    }
    bool match = (isnum)
        ? RegExp(r'^\d+$').hasMatch(text)
        : RegExp(r'^[a-z]+$').hasMatch(text);
    return match;
  }

  void signupPress() {
    bool nameCheck = validateText(textEditingController.value.text, false);
    bool numberCheck = validateText(numberEditingController.value.text, true);
    if (!nameCheck || !numberCheck) {
      setState(() {
        isValidNumber = numberCheck;
        isValidName = nameCheck;
      });
    } else {
      setState(() {
        signing = null;
      });
      initiateSignUP();
    }
  }

  Future<void> initiateSignUP() async {
    int value = await NetworkApi.vendorCreate(
        int.parse(numberEditingController.value.text),
        textEditingController.value.text);

    if (value == 0) {
      if (mounted) {
        setState(() {
          newID = int.parse(numberEditingController.value.text);
          signing = true;
          errorOccured = value;
        });
      }
    } else if (value == 1) {
      if (mounted) {
        setState(() {
          newID = null;
          signing = true;
          errorOccured = value;
        });
      }
    }

    if (value == 2) {
      if (mounted) {
        setState(() {
          newID = null;
          signing = true;
          errorOccured = value;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (signing == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "PLEASE DO NOT CLOSE THIS WINDOW.\nYOUR VENDOR-ID WILL BE GENERATED SOON!",
            style: TextStyle(
                fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(
            color: Colors.black,
          )
        ],
      );
    }

    if (!signing!) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLength: 12,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                errorText: (isValidName) ? null : "Only alphabets allowed!",
                labelText: "VENDOR NAME",
                labelStyle: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                // helperText: credentials,
                helperStyle:
                    const TextStyle(fontSize: 11, color: Colors.redAccent)),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            autofocus: true,
            controller: textEditingController,
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            maxLength: 8,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                errorText: (isValidNumber) ? null : "Only numbers allowed!",
                labelText: "VENDOR PHONE NUMBER",
                labelStyle: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                // helperText: credentials,
                helperStyle:
                    const TextStyle(fontSize: 11, color: Colors.redAccent)),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            autofocus: true,
            controller: numberEditingController,
          ),
          const SizedBox(
            height: 35,
          ),
          ElevatedButton(
              onPressed: signupPress, child: const Text("SIGN UP NOW")),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("OR"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("< LOGIN"))
        ],
      );
    } else {
      if (errorOccured == 0) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "VENDOR ID CREATED : $newID",
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                },
                child: const Text("LOGIN NOW"))
          ],
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              (errorOccured == 1)
                  ? "VENDOR ALREADY EXISTS IN DATABASE!"
                  : "SOME ERROR OCCURRED. PLEASE TRY LATER",
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isValidName = true;
                    isValidNumber = true;
                    textEditingController.clear();
                    numberEditingController.clear();
                    signing = false;
                    newID = null;
                    errorOccured = 0;
                  });
                },
                child: const Text("GO BACK"))
          ],
        );
      }
    }

  }
}
