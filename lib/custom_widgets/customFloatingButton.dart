import '/provider_dict/data_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({super.key});
  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  bool isLive = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if (isLive) {}

    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          isLive = !isLive;
        });
        Provider.of<DataChange>(context, listen: false).changeDataView(isLive);
      },
      icon: (isLive)? const Icon(Icons.storage_rounded,color: Colors.green,): const Icon(Icons.radio_button_checked_rounded,color: Colors.red,)
        ,
      isExtended: true,
      label: (isLive) ? const Text("Database") : const Text("Live Data"),
    );
  }
}
