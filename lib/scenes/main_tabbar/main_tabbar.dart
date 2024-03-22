import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_demo/constants/app_text_style.dart';
import 'package:shopping_demo/constants/constants.dart';

abstract class MainTabbarInterface {
  void onChangeTab(int index);
}

class MainTabbar extends StatefulWidget {
  const MainTabbar({Key? key}) : super(key: key);

  @override
  State<MainTabbar> createState() => MainTabbarState();
}

class MainTabbarState<T extends MainTabbar> extends State<T> implements MainTabbarInterface {
  CupertinoTabController tabController = CupertinoTabController();
  ValueChanged<int>? onSelected;

  @override
  void initState() {
    tabController.addListener(() {
      setState(() {});
    });
  }

  /// Build ///

  @override
  Widget build(BuildContext context) {
    // NOTE: Create Bottom Tab Bar
    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
        items: Constants.bottomBarItems,
        iconSize: 25,
        activeColor: Colors.black,
      ),
      tabBuilder: (BuildContext context, int index) {
        // NOTE: Return Pages according to the given index.
        return Constants.bottomBarPages[index];
      },
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
    );
  }

  /// UI ///

  Widget renderHeaderContainer({required String header}) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(header, style: xxxlargeBlackBold, textAlign: TextAlign.left),
    );
  }

  @override
  void onChangeTab(int index) {
  }
}