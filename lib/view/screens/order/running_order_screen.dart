import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/no_data_screen.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/history_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RunningOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'running_orders'.tr),
      body: GetBuilder<OrderController>(builder: (orderController) {

        return orderController.currentOrderList != null ? orderController.currentOrderList.length > 0 ? RefreshIndicator(
          onRefresh: () async {

          },
          child: Scrollbar(child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(child: SizedBox(
              width: 1170,
              child: ListView.builder(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                itemCount: orderController.currentOrderList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return HistoryOrderWidget(orderModel: orderController.currentOrderList[index], isRunning: true, index: index);
                },
              ),
            )),
          )),
        ) : NoDataScreen(text: 'no_order_found'.tr) : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
