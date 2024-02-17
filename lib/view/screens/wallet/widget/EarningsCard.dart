import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../util/app_constants.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class EarningsCard extends StatelessWidget {
  
  num OverallBalance;
  num todayBalance;
  num thisweekBalance;
  num thismonthBalance;
  EarningsCard({@required this.OverallBalance , @required this.todayBalance , @required this.thismonthBalance, @required this.thisweekBalance});

  NumberFormat formatter = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppConstants.Earningscardcolor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_LARGE,
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Image.asset(
                  Images.wallet,
                  height: 70,
                  width: 70,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.PADDING_SIZE_SMALL),
                    child: Text(
                      "Balance",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).cardColor,
                          fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                  ),
                  Text(
                    "RS ${formatter.format(OverallBalance)}",
                    style: robotoRegular.copyWith(
                        color: Theme.of(context).cardColor,
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DailyEarning(title: "Today",value: todayBalance),
                Container(height: 40,width: 1,color: Theme.of(context).cardColor,),
              DailyEarning(title: "This Week",value: thisweekBalance),
               Container(height: 40,width: 1,color: Theme.of(context).cardColor,),
              DailyEarning(title: "This Month",value:thismonthBalance),
            ],
          )
        ],
      ),
    );
  }
}

class DailyEarning extends StatelessWidget {
  String title;
   num value;
  DailyEarning({@required this.title,@required this.value});

  NumberFormat formatter = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: robotoRegular.copyWith(
              color: Theme.of(context).cardColor,
              fontSize: Dimensions.FONT_SIZE_SMALL),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        Text(
          "Rs  ${formatter.format(value)}",
          style: robotoRegular.copyWith(
              color: Theme.of(context).cardColor,
              fontSize: Dimensions.FONT_SIZE_LARGE),
        ),
      
      ],
    );
  }
}
