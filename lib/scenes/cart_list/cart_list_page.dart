import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopping_demo/constants/app_color.dart';
import 'package:shopping_demo/helpers/AlertHelper.dart';
import 'package:shopping_demo/helpers/FormatHelper.dart';
import 'package:shopping_demo/models/cart_item.dart';
import 'package:shopping_demo/models/product.dart';
import 'package:shopping_demo/providers/product_provider.dart';
import 'package:shopping_demo/scenes/cart_list/cart_list_interactor.dart';
import 'package:shopping_demo/scenes/cart_list/cart_list_router.dart';
import 'package:shopping_demo/widgets/add_cart.dart';
import 'package:shopping_demo/widgets/change_cart.dart';
import 'package:shopping_demo/widgets/product_quantity.dart';

import '../../constants/app_text_style.dart';

class CartListPage extends StatefulWidget {
  const CartListPage({super.key});

  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
  late CartListInteractor _interactor;
  late CartListRouter _router;

  @override
  void initState() {
    super.initState();
    _interactor = CartListInteractor(context);
    _router = CartListRouter(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _addNewCart({required String name}) {
    _interactor.addNewCart(name: name);
    setState(() {});
  }

  // Add: adding the product by 1 from cart list.
  void _onTapAddProduct({required CartItem cart}) {
    _interactor.addProduct(cart: cart);
  }

  // Remove: removing the product by 1 from cart list.
  void _onTapRemoveProduct({required Product product}) {
    _interactor.removeProduct(product: product);
  }

  // Delete: deleting the product from cart list regardless of its quantity.
  void _onTapDeleteProduct({required Product product}) {
    _interactor.deleteProduct(product: product);
  }

  // Delete: deleting the product from cart list regardless of its quantity.
  void _onTapCheckout() {
    _interactor.checkOutCart();
    AlertHelper.showAlert(
        context: context,
        title: "Payment successfully",
        description: "You can track status order in Tracking menu");
  }

  void _onTapDeleteCart() {
    _interactor.deleteCart();
    setState(() {});
  }

  void _showChangeCartDialog() {
    final cartSelectedIndex = _interactor.getCartSelectedIndex();
    final cartList  = _interactor.getCartList();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeCart(cartList: cartList,
            selectedIndex: cartSelectedIndex,
            onSelected: (index) {
              _interactor.changeCartByIndex(index);
              setState(() {});
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Cart", maxLines: 1, style: largeBlackBold),
          backgroundColor: whiteColor,
          actions: [_renderAddCartButton()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _renderCartSelectingView(),
          _renderListView(),
          _renderTotalPrice()
        ],
      ),
    );
  }

  Widget _renderCartSelectingView() {
    final cartName = _interactor.getCartName();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 46,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _showChangeCartDialog();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: greyColor,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(cartName, style: mediumBlack, textAlign: TextAlign.center)),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 30,
            child: IconButton(
                onPressed: () => _onTapDeleteCart(),
                icon: Icon(Icons.delete)
            ),
          )
        ],
      ),
    );
  }

  Widget _renderListView() {
    final cartProductList = _interactor.getCartProductList();

    return Expanded(
      // NOTE: `SlidableAutoCloseBehavior`
      // set `groupTag` to 0, to make the slide open only one at a time.
      child: SlidableAutoCloseBehavior(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: cartProductList.length,
          itemBuilder: (BuildContext context, int index) {
            final CartItem cartItem = cartProductList[index];
            final Product product = cartItem.product;

            return Slidable(
              key: ObjectKey(cartProductList[index]),
              groupTag: 0,
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                dragDismissible: false,
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      _onTapDeleteProduct(product: product);
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.remove_circle,
                    label: 'Delete',
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  // height: 180,
                  color: Colors.grey.shade200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _renderProductImage(imageUrl: product.imageUrl),
                      _renderProductDetail(cartItem: cartItem),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _renderProductImage({required String imageUrl}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
      child: Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
    );
  }

  Widget _renderProductName({required String name}) {
    return Text(
      name,
      style: largePrimaryBold,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  Widget _renderNote({required String note}) {
    return Text(note, style: mediumBlack, maxLines: null);
  }

  Widget _renderProductPrice({required String price}) {
    return Text(price, style: largeDarkGrey, maxLines: 1);
  }

  Widget _renderProductDetail({required CartItem cartItem}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _renderProductName(name: cartItem.product.name),
            const SizedBox(height: 4),
            _renderProductPrice(price: cartItem.product.formattedPrice),
            const SizedBox(height: 4),
            _renderNote(note: cartItem.note ?? ""),
            const SizedBox(height: 4),
            _renderQuantityContainer(cartItem: cartItem),
          ],
        ),
      ),
    );
  }
  Widget _renderQuantityContainer({required CartItem cartItem}) {
    return ProductQuantity(quantity: cartItem.quantity, onChanged: (int value) {
      if (value > 0) { // -1 is remove, 1 is add
        _onTapAddProduct(cart: cartItem);
      } else {
        _onTapRemoveProduct(product: cartItem.product);
      }
    });
  }

  Widget _renderTotalPrice() {
    final double totalPrice = _interactor.getTotalPrice();
    final String formattedTotalPrice = FormatHelper.formatPrice(totalPrice);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: Colors.grey.shade300,
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                const Text(
                  'Total Price:',
                  style: mediumBlack,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 10),
                Text(formattedTotalPrice, style: xlargeBlackBold, maxLines: 1),
                const Spacer(),
                TextButton(
                  onPressed: () => _onTapCheckout(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(2),
                    child: Text('Checkout', style: mediumWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderAddCartButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddCart(onComplete: (name) {
                _addNewCart(name: name);
              });
            },
          );
        },
        child: Row(
          children: [
            Icon(Icons.shopping_cart, size: 24, color: blackColor),
            Icon(Icons.add_circle, size: 16, color: blackColor),
          ],
        ),
      ),
    );
  }
}
