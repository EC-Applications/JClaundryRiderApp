import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderFilterWidget extends StatelessWidget {
  final Function(String value) onSelected;
  const OrderFilterWidget({Key key,  @required this.onSelected, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry> entryList = [
      PopupMenuItem(value: 'all', child: Row(
        children: [
          Get.find<OrderController>().filterValue == 'all'
              ? Icon(Icons.radio_button_checked_sharp, color: Theme.of(context).primaryColor)
              : Icon(Icons.radio_button_off, color: Theme.of(context).disabledColor),
          const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

          Text(
            'all'.tr,
            style: robotoMedium.copyWith(color: Get.find<OrderController>().filterValue == 'all'
                ? Theme.of(context).textTheme.bodyMedium.color : Theme.of(context).disabledColor),
          ),
        ],
      )),
      PopupMenuItem(value: 'picked_up', child: Row(
        children: [
          Get.find<OrderController>().filterValue == 'picked_up'
              ? Icon(Icons.radio_button_checked_sharp, color: Theme.of(context).primaryColor)
              : Icon(Icons.radio_button_off, color: Theme.of(context).disabledColor),
          const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

          Text(
            'picked_up'.tr,
            style: robotoMedium.copyWith(color: Get.find<OrderController>().filterValue == 'picked_up'
                ? Theme.of(context).textTheme.bodyMedium.color : Theme.of(context).disabledColor),
          ),
        ],
      )),
      PopupMenuItem(value: 'delivered', child: Row(
        children: [
          Get.find<OrderController>().filterValue == 'delivered'
              ? Icon(Icons.radio_button_checked_sharp, color: Theme.of(context).primaryColor)
              : Icon(Icons.radio_button_off, color: Theme.of(context).disabledColor),
          const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

          Text(
            'delivered'.tr,
            style: robotoMedium.copyWith(color: Get.find<OrderController>().filterValue == 'delivered'
                ? Theme.of(context).textTheme.bodyMedium.color : Theme.of(context).disabledColor),
          ),
        ],
      )),
    ];


   return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: PopupMenuButton<dynamic>(
        offset: const Offset(-20, 20),
        itemBuilder: (BuildContext context) => entryList,
        onSelected: (dynamic value) => onSelected(value),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
              color: Theme.of(context).cardColor,
              border: Border.all(color: Theme.of(context).primaryColor, width: 1)
          ),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Row(mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.filter_list, size: 24, color: Theme.of(context).primaryColor),
              const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                'filter'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}