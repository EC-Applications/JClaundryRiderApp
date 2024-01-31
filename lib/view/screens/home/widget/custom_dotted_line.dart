import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class CustomDottedLine extends StatelessWidget {
  final double lineLength;
  final double dashGapLength;
  CustomDottedLine({this.lineLength = 50, this.dashGapLength = 2});

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: Axis.vertical,
      dashColor: Theme.of(context).primaryColor,
      dashLength: 2,
      dashGapLength: dashGapLength,
      lineLength: lineLength,
    );
  }
}
