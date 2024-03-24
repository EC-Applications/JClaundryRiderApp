import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../util/app_constants.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';

class CashInHand extends StatelessWidget {
    
    num handcash;
    CashInHand({@required this.handcash});
  
  NumberFormat formatter = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppConstants.handcahscardcolor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
                       "Rs  ${formatter.format(handcash)}",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).cardColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold
                          ),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Text(
                      "Cash In Your Hand",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).cardColor,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          fontWeight: FontWeight.w500
                          ),
                    ),
        ],
      ),
    );
  }
}