import 'package:flutter/material.dart';
import 'package:shopping_demo/constants/app_text_style.dart';

class AddCart extends StatelessWidget {
  AddCart({
    super.key,
    required this.onComplete,
  });

  final ValueChanged<String> onComplete;
  final nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("New Cart", style: xxlargeBlackBold, maxLines: 1, textAlign: TextAlign.left),
          SizedBox(height: 8),
          _renderNote(),
          SizedBox(height: 16),
          _renderConfirmButton(context)
        ],
      ),
    );
  }

  Widget _renderNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Name", style: largeBlack, maxLines: 1, textAlign: TextAlign.left),
        const SizedBox(height: 8),
        TextField(
            controller: nameTextController,
            maxLines: 1,
            maxLength: 12,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Pleases input new cart name',
              border: OutlineInputBorder(),
            )
        )
      ],
    );
  }

  Widget _renderConfirmButton(BuildContext context) {
    return SizedBox(
      height: 44,
      child: TextButton(
        onPressed: () {
          if (nameTextController.text.isNotEmpty) {
            onComplete(nameTextController.text);
            Navigator.of(context).pop();
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: const Text('Confirm', style: xlargeWhite),
      ),
    );
  }
}
