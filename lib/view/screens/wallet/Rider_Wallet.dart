import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:efood_multivendor_driver/util/images.dart';
import 'package:get/get.dart';

import '../../../controller/laundry_notification_controller.dart';
import '../../../controller/rider_wallet_controller.dart';
import '../../../helper/route_helper.dart';
import '../../../util/dimensions.dart';
import 'widget/EarningsCard.dart';
import 'widget/cash_in_hand.dart';
import 'widget/toggle_button.dart';

class RiderWallet extends StatefulWidget {
  const RiderWallet({Key key}) : super(key: key);

  @override
  State<RiderWallet> createState() => _RiderWalletState();
}

class _RiderWalletState extends State<RiderWallet> {
   bool isButtonActive = true;
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        // leading: Image.asset(Images.logo,width: 10,height: 10,),
        title: Image.asset(
          Images.logo_name,
          width: 150,
          height: 150,
        ),
        actions: [

          // InkWell(
          //   onTap: () {
          //     // Get.find<LaundryNotificationController>().clearNotification();
          //     // Get.find<LaundryNotificationController>().getNotificationList(1);
          //     // Get.toNamed(RouteHelper.getLaundryNotificationRoute());
          //   },

          //   child: GetBuilder<LaundryNotificationController>(

          //       builder: (notificationController) {
          //     bool _hasNewNotification = false;
          //     if (notificationController
          //             .paginationLaundryNotificationModel?.data !=
          //         null) {
          //       _hasNewNotification = notificationController
          //               .paginationLaundryNotificationModel?.data?.length !=
          //           notificationController.getSeenNotificationCount();
          //     }
          //     return Container(
          //       alignment: Alignment.center,
          //       height: 44,
          //       width: 44,
          //       child: Stack(
          //         children: [
          //           Icon(
          //             Icons.notifications,
          //              size: 24,
          //             color: Theme.of(context).textTheme.bodyLarge.color,
          //             ),
                 
          //           _hasNewNotification
          //               ? Positioned(
          //                   top: 2,
          //                   right: 2,
          //                   child: Container(
          //                     height: 8,
          //                     width: 8,
          //                     decoration: BoxDecoration(
          //                         shape: BoxShape.circle,
          //                         color: Theme.of(context).primaryColor),
          //                   ),
          //                 )
          //               : SizedBox(),
          //         ],
          //       ),
          //     );
          //   }),
          // ),

          // ToggleButton(title: "test",isButtonActive: isButtonActive,
          //     onTap: (){
          //       setState(() {
          //     isButtonActive = !isButtonActive;
          //   });
          //     },
          //     )
          // //  GetBuilder<RiderWalletController>(
          // //   builder: (riderwalletcontroller) {
          // //    return ToggleButton(title: "test",isButtonActive: riderwalletcontroller.isButtonActive,
          // //     onTap: (){
          // //       riderwalletcontroller.setButtonActive(!riderwalletcontroller.isButtonActive);
          // //     },
          // //     );
          // //   } ,
          // //  )
        ],
      ),
      body: Scrollbar(child: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Text("Earnings"),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    EarningsCard(
                    OverallBalance: 1223.00,
                    todayBalance: 290.86,
                    thismonthBalance: 2092.36,
                    thisweekBalance: 4259.26,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    CashInHand(handcash: 6721.25,)


          
        

        

        ]),
      )),
    );
  }
}
