import 'package:flutter/material.dart';
import '../common/style/constants.dart';
import '../common/style/ui.dart';

class MenuPage extends StatelessWidget {
  final Function() onTap;
  final int itemCount;
  final double buttonSize;
  const MenuPage({
    super.key,
    required this.onTap,
    required this.itemCount,
    required this.buttonSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      height: size.height / 3,
      margin: EdgeInsets.only(top: buttonSize),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              title: Text(
                menuItems[index],
                textAlign: TextAlign.center,
                style: UI.menuItemTextStyle,
              ),
            );
          }),
    );
  }
}
