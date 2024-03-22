import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/constants/app_color.dart';
import 'package:shopping_demo/models/product.dart';
import 'package:shopping_demo/providers/product_provider.dart';
import 'package:shopping_demo/scenes/selecting_product/selecting_product_interactor.dart';
import 'package:shopping_demo/scenes/selecting_product/selecting_product_router.dart';
import 'package:shopping_demo/widgets/product_quantity.dart';

import '../../constants/app_text_style.dart';

class SelectingProductPage extends StatefulWidget {
  const SelectingProductPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<SelectingProductPage> createState() => _SelectingProductPageState();
}

class _SelectingProductPageState extends State<SelectingProductPage> {
  late SelectingProductInteractor _interactor;
  late SelectingProductRouter _router;

  TextEditingController noteTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _interactor = SelectingProductInteractor(context, product: widget.product);
    _router = SelectingProductRouter(context);

    initOldData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initOldData() {
    noteTextController.text = _interactor.productInCart?.note ?? "";
    setState(() {});
  }

  void _onTapAddToCartButton({required Product product}) {
    _interactor.addProductToCart(note: noteTextController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductProvider>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text("Product", maxLines: 1, style: largeBlackBold),
            backgroundColor: whiteColor
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderProductImage(),
              const SizedBox(height: 16),
              _renderDetail()
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderProductName(),
          const SizedBox(height: 8),
          _renderProductDescription(),
          const SizedBox(height: 8),
          _renderProductPrice(),
          const SizedBox(height: 16),
          _renderQuantity(),
          const SizedBox(height: 16),
          _renderNote(),
          const SizedBox(height: 16),
          _renderAddToCartButton(),
          const SizedBox(height: 16),
        ]
      ),
    );
  }

  Widget _renderProductImage() {
    return Image.network(
      _interactor.product.imageUrl,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 1.5,
      fit: BoxFit.cover,
    );
  }

  Widget _renderProductDescription() {
    return Text(
      _interactor.product.description,
      style: largeBlack,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _renderProductName() {
    return Text(
      _interactor.product.name,
      style: xxlargeBlackBold,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _renderProductPrice() {
    return Text(_interactor.product.formattedPrice, style: xxlargeDarkGrey, maxLines: 1, textAlign: TextAlign.right);
  }

  Widget _renderQuantity() {
    return ProductQuantity(quantity: _interactor.quantity, onChanged: (int value) {
      _interactor.quantity += value;
      setState(() {});
    });
  }

  Widget _renderNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Note", style: largeBlack, maxLines: 1, textAlign: TextAlign.left),
        const SizedBox(height: 8),
        TextField(
            controller: noteTextController,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'You can note in here.',
              border: OutlineInputBorder(),
            )
        )
      ],
    );
  }

  Widget _renderAddToCartButton() {
    return SizedBox(
      height: 44,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: () => _onTapAddToCartButton(product: _interactor.product),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: const Text('Add to Cart', style: xlargeWhite),
      ),
    );
  }
}
