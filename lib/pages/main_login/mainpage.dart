import '/pages/adminpage/adminpage.dart';
import '../../custom_widgets/customFloatingButton.dart';
import 'login_box.dart';
import '/provider_dict/data_change.dart';
import '/services/network_api.dart';
import '../../data/userdata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  String vendorName = '';
  bool? userLoggedIn;
  int vendorId = -1;

  void login(String loginVendorName, int id) {
    setState(() {
      userLoggedIn = null;
      vendorName = '';
    });

    Future.delayed(const Duration(seconds: 0), () {
      if (mounted) {
        setState(() {
          userLoggedIn = true;
          vendorName = loginVendorName;
          vendorId = id;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(Duration.zero, () async {
      var pref = await SharedPreferences.getInstance();
      int? storedVendorID = pref.getInt("vendorID");
      if (storedVendorID == null) {
        if (mounted) {
          setState(() {
            userLoggedIn = false;
          });
        }
      } else {
        UserLoggedInData? userLoggedInData =
            await NetworkApi.authUser(storedVendorID);
        if (mounted) {
          if (userLoggedInData != null) {
            setState(() {
              userLoggedIn = true;
              vendorName = userLoggedInData.name;
              vendorId = storedVendorID;
            });
          } else {
            setState(() {
              userLoggedIn = false;
              vendorName = '';
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userLoggedIn == null) {
      return Scaffold(
        backgroundColor: Colors.grey.shade600,
        appBar: AppBar(
          title: const Text("Feedback"),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (BuildContext changeNotifierProvider) {
        return DataChange();
      },
      builder: (builderContext, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          floatingActionButton: (userLoggedIn!) ? const CustomFloatingButton() : null,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Feedback $vendorName"),
            actions: (userLoggedIn!)
                ? [
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            userLoggedIn = null;
                            vendorName = '';
                          });
                          var pref = await SharedPreferences.getInstance();
                          await pref.remove("vendorID");
                          // await Future.delayed(const Duration(seconds: 0));
                          if (mounted) {
                            setState(() {
                              userLoggedIn = false;
                            });
                          }
                        },
                        child: const Text("LOGOUT"))
                  ]
                : null,
          ),
          body: Center(
            child: (!userLoggedIn!)
                ? SizedBox(
                    width: 320, height: 200, child: Login(loginFunction: login))
                : AdminPage(
                    vendorID: vendorId,
                  ),
          ),
        );
      },
    );
  }
}
