import 'package:flutter/material.dart';
import 'package:shopping_demo/widgets/alert_view.dart';

class AlertHelper {
  static showAlert({required BuildContext context, required String title, required String description}) {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertView(title: title, description:  description);
    });
  }
}
