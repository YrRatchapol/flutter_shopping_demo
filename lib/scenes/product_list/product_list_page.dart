import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/constants/app_color.dart';
import 'package:shopping_demo/providers/product_provider.dart';
import 'package:shopping_demo/scenes/main_tabbar/main_tabbar.dart';
import 'package:shopping_demo/scenes/product_list/product_list_interactor.dart';
import 'package:shopping_demo/scenes/product_list/product_list_router.dart';
import 'package:shopping_demo/widgets/product_card.dart';

import '../../constants/app_text_style.dart';

class ProductListPage extends MainTabbar {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends MainTabbarState<ProductListPage> {
  late ProductListInteractor _interactor;
  late ProductListRouter _router;

  @override
  void initState() {
    super.initState();
    _interactor = ProductListInteractor(context);
    _router = ProductListRouter(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Product List", maxLines: 1, style: largeBlackBold),
        backgroundColor: whiteColor,
        actions: [_renderCartButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderGridView(),
            ],
        ),
      ),
    );
  }

  /// UI ///

  Widget _renderGridView() {
    final productList = _interactor.getProductList();
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 24),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: productList.length,
        itemBuilder: (BuildContext context, index) {
          final product = productList[index];
          return ProductCard(
            product: product,
            onTapCard: () => _router.toProductPage(product: product),
          );
        },
      ),
    );
  }

  Widget _renderCartButton() {
    return IconButton(
      icon: const Icon(Icons.shopping_cart, size: 25),
      color: blackColor,
      onPressed: () {
        _router.toCartList();
      },
    );
  }
}
