import 'dart:convert';

import 'package:feedback_view/pages/adminpage/adminpage.dart';
import 'package:feedback_view/pages/login_singup_page.dart';
import 'package:feedback_view/services/auth_service.dart';
import 'package:feedback_view/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.service.init();
  var key = StorageService.service.getKey();
  http.Response res = await AuthService.service.authVendor(key);
  if (res.statusCode == 200) {
    Map<String,dynamic> map = jsonDecode(res.body);
    await StorageService.service.addCustomKey('username', map['vendor_name']);
    await StorageService.service.addCustomKey('logged', '1');
    await StorageService.service.addCustomKey('phone', "${map['vendor_phone_number']}");
  } else await StorageService.service.addCustomKey('logged', '0');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: MaterialColor(Colors.black.value, const {
            50: Color(0xffe8e8e8), //10%
            100: Color(0xffb2b2b2), //20%
            200: Color(0xff8a8a8a), //30%
            300: Color(0xff4d4d4d), //40%
            400: Color(0xff484848), //50%
            500: Color(0xff3a3a3a), //60%
            600: Color(0xff2d2d2d), //70%
            700: Color(0xff1a1a1a), //80%
            800: Color(0xff171717), //90%
            900: Color(0xff000000), //100%
          }),
          primaryColorDark: Colors.black,
          primaryColorLight: Colors.black12),
      initialRoute: ((StorageService.service.getCustomKey('logged') as String)
                  .compareTo('1') ==
              0)
          ? "/database_view_page"
          : "/login_signup_page",
      routes: {
        "/login_signup_page": (ctx) => const LoginSignUpPage(),
        "/database_view_page": (ctx) => const AdminPage(),
      },
    );
  }
}
