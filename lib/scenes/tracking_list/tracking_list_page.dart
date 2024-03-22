import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/constants/app_color.dart';
import 'package:shopping_demo/helpers/FormatHelper.dart';
import 'package:shopping_demo/models/cart_model.dart';
import 'package:shopping_demo/providers/product_provider.dart';
import 'package:shopping_demo/scenes/main_tabbar/main_tabbar.dart';
import 'package:shopping_demo/scenes/tracking_list/tracking_list_interactor.dart';
import 'package:shopping_demo/scenes/tracking_list/tracking_list_router.dart';

import '../../constants/app_text_style.dart';

class TrackingListPage extends MainTabbar {
  const TrackingListPage({super.key});

  @override
  State<TrackingListPage> createState() => _TrackingListPageState();
}

class _TrackingListPageState extends MainTabbarState<TrackingListPage> {
  late TrackingListInteractor _interactor;
  late TrackingListRouter _router;

  @override
  void initState() {
    super.initState();
    _interactor = TrackingListInteractor(context);
    _router = TrackingListRouter(context);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductProvider>();
    final cartList = _interactor.getCheckoutCartList();
    return Scaffold(
      appBar: AppBar(
          title: Text("Tracking", maxLines: 1, style: largeBlackBold),
          backgroundColor: whiteColor
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: cartList.length,
        itemBuilder: (BuildContext context, int index) {
          return _renderCartRow(context: context, cart: cartList[index], index: index);
        },
      ),
    );
  }

  Widget _renderCartRow({ required BuildContext context, required CartModel cart, required int index}) {
    final double totalPrice = _interactor.getTotalPriceByCartIndex(index);
    final String formattedTotalPrice = FormatHelper.formatPrice(totalPrice);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cart.cartName, style: xxlargeBlackBold),
                  Text("(Paid)", style: largeBlackBold),
                ]
              ),
              SizedBox(height: 8),
              Container(height: 0.5, color: greyColor),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: cart.cartProductList.length,
                itemBuilder: (BuildContext context, int index) {
                  final cartItem = cart.cartProductList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("- ${cartItem.product.name} x${cartItem.quantity}", style: mediumBlack),
                      Text(cartItem.product.formattedPrice , style: mediumBlack, textAlign: TextAlign.end),
                    ],
                  );
                },
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: mediumBlackBold),
                  Text(formattedTotalPrice, style: xlargeBlackBold),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
