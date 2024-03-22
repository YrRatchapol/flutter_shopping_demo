import 'package:flutter/material.dart';
import 'package:shopping_demo/constants/app_text_style.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  final int quantity;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 34,
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            icon: const Icon(Icons.remove_circle_outline_outlined),
            color: Colors.black,
            onPressed: () {
              onChanged(-1);
            },
          ),
        ),
        Text(quantity.toString(), style: xlargeBlackBold, maxLines: 1),
        SizedBox(
          width: 34,
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            icon: const Icon(Icons.add_circle_outline_outlined),
            color: Colors.black,
            onPressed: () {
              onChanged(1);
            },
          ),
        ),
      ],
    );
  }
}
