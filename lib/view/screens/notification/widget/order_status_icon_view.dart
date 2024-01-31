import 'package:flutter/material.dart';

class OrderStatusIconView extends StatelessWidget {
  final Color color;
  final String imgUrl;
  final double imgHeight;
  final double imgWidth;

  OrderStatusIconView({
    @required this.color,
    @required this.imgUrl,
    this.imgHeight = 18,
    this.imgWidth = 18,
  });




  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Image.asset(imgUrl, height: imgHeight, width: imgWidth,),
    );
  }
}
