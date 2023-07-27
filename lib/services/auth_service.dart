import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  AuthService._singleton();
  static final http.Response connectionResponse = http.Response("", 500,headers: {
    'error': "unable to connect. please check your internet connection."
  });
  static final AuthService service = AuthService._singleton();
  static final Uri uri = Uri.parse("http://localhost:8080/vendor/auth");
  static final Uri createVendorUri =
      Uri.parse("http://localhost:8080/vendor/signup");
  static final Uri loginVendorUri =
      Uri.parse("http://localhost:8080/vendor/login");

  Future<http.Response> authVendor(String? key) async {
    http.Response response = connectionResponse;
    try {
      http.Response res = await http.get(uri, headers: {
        'auth-token': key ?? '',
        "Access-Control-Allow-Headers": "*",
        "Access-Control-Expose-Headers": "*"
      });
      response = res;
    } catch (e) {}
    return response;
  }

  Future<http.Response> vendorLogin(String phoneNumber) async {
    http.Response response = connectionResponse;
    try {
      http.Response res = await http.post(loginVendorUri,
          headers: {
            'Content-Type': 'application/json',
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Expose-Headers": "*"
          },
          body: jsonEncode({
            'vendor_phone_number': phoneNumber,
          }));
      response = res;
    } catch (e) {}
    return response;
  }

  Future<http.Response> createVendor(
      String vendorname, String phonenumber, String upi) async {
    http.Response response = http.Response("", 500, headers: {
      'error': "unable to connect. please check your internet connection."
    });

    try {
      http.Response res = await http.post(createVendorUri,
          headers: {
            'Content-Type': 'application/json',
            "Access-Control-Allow-Headers": "*",
            "Access-Control-Expose-Headers": "*"
          },
          body: jsonEncode(<String, String>{
            'vendor_name': vendorname,
            'vendor_phone_number': phonenumber,
            'vendor_upi': upi,
          }));
      response = res;
    } catch (e) {
      return response;
    }
    return response;
  }
}
