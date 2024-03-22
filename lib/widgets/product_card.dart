import 'package:flutter/material.dart';
import 'package:shopping_demo/constants/app_text_style.dart';
import 'package:shopping_demo/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTapCard,
  });

  final Product product;
  final VoidCallback onTapCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              children: [
                Expanded(child: Image.network(product.imageUrl, fit: BoxFit.fitHeight)),
                Container(
                  height: 60,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, maxLines: 1, style: microPrimary, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(product.formattedPrice, maxLines: 1, style: microPrimaryBold),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
