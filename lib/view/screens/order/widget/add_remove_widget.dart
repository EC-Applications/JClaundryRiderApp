import 'package:flutter/material.dart';

class AddRemoveWidget extends StatelessWidget {
  final String imgUrl;
  final Function onTap;


  AddRemoveWidget({@required this.imgUrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFC3C8D2), width: 1)
        ),
        child: Container(alignment: Alignment.center, child: Image.asset(imgUrl, height: 12, width: 12, color: Theme.of(context).textTheme.bodyLarge.color,)),
      ),
    );
  }
}
