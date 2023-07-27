import 'package:feedback_view/custom_widgets/floating_reload_button.dart';
import 'package:feedback_view/extras/styles.dart';
import 'package:feedback_view/providers/vendor_feedback_provider.dart';
import 'package:feedback_view/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dialogs/logout_dialog_box.dart';
import 'database_view.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VendorFeedbackProvider>(
      create: (ctx)=>VendorFeedbackProvider(),
      child: Scaffold(
        floatingActionButton: const FloatingReloadButton(),
        backgroundColor: const Color.fromRGBO(241, 227, 255, 1.0),
        appBar: AppBar(
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(context: context,barrierDismissible: false, builder: (ctx) {
                    return const LogoutDialogBox();
                  });
                },
                style: AppStyles.accessButtons,
                child: const Text('logout'),
              ),
            ),
          ],
          title: Text(
              (StorageService.service.getCustomKey('username') as String) ?? ''),
        ),
        body: const StaticData(
          vendorID: 65456,
        ),
      ),
    );
  }
}
