import 'package:feedback_view/pages/main_login/mainpage.dart';
import 'package:feedback_view/pages/signup/sign_up.dart';
import 'package:flutter/material.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColorDark: Colors.lightBlueAccent,
        primaryColorLight: Colors.blue.shade200
      ),

      home: const MainPage(),
      routes: {
        "/signup":(ctx){
          return const SignUpPage();
        }
      },
    );
  }
}


