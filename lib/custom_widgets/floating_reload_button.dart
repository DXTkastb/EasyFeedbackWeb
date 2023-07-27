import 'package:feedback_view/providers/vendor_feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingReloadButton extends StatelessWidget {
  const FloatingReloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorFeedbackProvider>(
      builder: (ctx, vfp, wid) {
        return FloatingActionButton(
          onPressed: () {
            if (vfp.reloading) return;
            vfp.reload();
          },
          child: (vfp.reloading)
              ? const SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ))
              : const Icon(Icons.replay),
        );
      },
    );
  }
}
