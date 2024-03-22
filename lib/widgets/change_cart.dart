import 'package:flutter/material.dart';
import 'package:shopping_demo/constants/app_color.dart';
import 'package:shopping_demo/constants/app_text_style.dart';
import 'package:shopping_demo/models/cart_model.dart';

class ChangeCart extends StatelessWidget {
  ChangeCart({
    super.key,
    required this.cartList,
    required this.selectedIndex,
    required this.onSelected,
  });

  List<CartModel> cartList;
  final ValueChanged<int> onSelected;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Change Cart", style: xxlargeBlackBold, maxLines: 1, textAlign: TextAlign.left),
          SizedBox(height: 8),
          _renderList(),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _renderList() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      width: double.maxFinite,
      height: 400,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: cartList.length,
          itemBuilder: (BuildContext context, int index) {
            return _renderCartRow(context, index);
            return Container(height: 60, color: Colors.red);
          },
      ),
    );
  }

  Widget _renderCartRoww(BuildContext context, int index) {
    final cart = cartList[index];
    return GestureDetector(
      onTap: () {
        onSelected(index);
        Navigator.pop(context);
      },
      child: Container(
        height: 40,
        child: Column(
          children: [
            Row(children: [
                Text(cart.cartName, style: xlargeBlack),
                Spacer(),
                index == selectedIndex ? Icon(Icons.check) : Container()
            ]),
            SizedBox(height: 8),
            Container(height: 0.5, color: greyColor),
          ],
        ),
      ),
    );
  }

  Widget _renderCartRow(BuildContext context, int index) {
    final cart = cartList[index];
    return TextButton(
      onPressed: () {
        onSelected(index);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(children: [
            Text(cart.cartName, style: xlargeBlack),
            Spacer(),
            index == selectedIndex ? Icon(Icons.check, color: blackColor) : Container()
          ]),
          SizedBox(height: 8),
          Container(height: 0.5, color: greyColor),
        ],
      ),
    );
  }
}
