import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../util/dimensions.dart';

class CustomButtonSec extends StatelessWidget {
final String btntext;
final Color bgColor;
final Color fontColor;
final Color bordercolor;
final VoidCallback callback;
CustomButtonSec({@required this.btntext, @required this.fontColor, @required this.bordercolor,@required this.bgColor,@required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: 50,
        width : MediaQuery.of(context).size.width * 0.450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
          border: Border.all(color:bordercolor,width: 2 ),
            color: bgColor
        ),
        child: Center(
          child: Text(btntext,style: TextStyle(
            color: fontColor,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),),
        ),
      ),
    );
  }
}