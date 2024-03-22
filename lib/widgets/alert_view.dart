import 'package:flutter/material.dart';
import 'package:shopping_demo/constants/app_text_style.dart';

class AlertView extends StatelessWidget {
  AlertView({ super.key, this.title, this.description});

  String? title;
  String? description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title ?? "-", style: largeBlackBold, maxLines: 2, textAlign: TextAlign.center),
          SizedBox(height: 16),
          Text(description ?? "-", style: mediumBlack, maxLines: 10, textAlign: TextAlign.center),
          SizedBox(height: 16),
          _renderCloseButton(context)
        ],
      ),
    );
  }

  Widget _renderCloseButton(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: const Text('Close', style: xlargeWhite),
      ),
    );
  }
}
