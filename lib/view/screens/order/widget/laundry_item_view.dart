import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/laundry_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaundryItemView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<OrderController>(builder: (orderController) {
      return GetBuilder<LaundryCartController>(builder: (cartController) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.5))
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.bodyLarge.color,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.RADIUS_DEFAULT), topLeft: Radius.circular(Dimensions.RADIUS_DEFAULT)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'laundry_items'.tr,
                        style: robotoBold.copyWith(
                            color: Theme.of(context).cardColor,
                            fontSize: Dimensions.FONT_SIZE_LARGE
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        orderController.setEditedValue(true);
                      },
                      child: !orderController.isEdited ? Image.asset(
                        Images.edit,
                        height: 30,
                        width: 30,
                      ) : SizedBox(),
                    ),
                  ],
                ),
              ),

              LaundryItemWidget(),

              // Divider(thickness: 1),
              //
              // Padding(
              //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              //   child: LaundryItemWidget(),
              // ),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

            ],
          ),
        );
      });
    });
  }
}
