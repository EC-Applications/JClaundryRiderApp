
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:efood_multivendor_driver/view/base/laundry_title_widget.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/adress_view_laundry.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/price_view_laundry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderDetailsScreen extends StatefulWidget {

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (laundryLocationController) {
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: CustomAppBar(title: 'order_details'.tr,),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                child: LaundryTitleWidget(titleName: 'price_details',),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT,horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_LARGE),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                ),
                child: PriceViewLaundry(
                  total: 'Rs. 1,427',
                  subtotal: 'Rs. 1,327',
                  deliveryFee: 'Rs. 100',
                ),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                child: LaundryTitleWidget(titleName: 'schedule_date',),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
                        border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.4))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {

                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                                child: Row(
                                  children: [
                                    Image.asset(Images.calender_add, height: 24, width: 24, color: Theme.of(context).disabledColor),
                                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'time',
                                            style: robotoRegular.copyWith(
                                                color: Theme.of(context).textTheme.bodyLarge.color,
                                                fontSize: Dimensions.FONT_SIZE_DEFAULT
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'time',
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context).textTheme.bodyLarge.color,
                                                fontSize: Dimensions.FONT_SIZE_LARGE
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container( child: VerticalDivider(color: Colors.transparent,),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {

                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                                child: Row(
                                  children: [
                                    Image.asset(Images.calender_check, height: 24, width: 24, color: Theme.of(context).disabledColor,),
                                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'data',
                                            style: robotoRegular.copyWith(
                                                color: Theme.of(context).textTheme.bodyLarge.color,
                                                fontSize: Dimensions.FONT_SIZE_DEFAULT
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'data',
                                            style: robotoMedium.copyWith(
                                                color: Theme.of(context).textTheme.bodyLarge.color,
                                                fontSize: Dimensions.FONT_SIZE_LARGE
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    left: 50,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      color: Theme.of(context).cardColor,
                      child: Text('pickup'.tr),
                    ),
                  ),

                  Positioned(
                    right: 80,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      color: Theme.of(context).cardColor,
                      child: Text('delivery'.tr),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: MediaQuery.of(context).size.width / 2 - 10,
                    child: Container(height: 36, child: VerticalDivider(color: Theme.of(context).disabledColor.withOpacity(.4), thickness: 1,),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width / 2 - 10,
                    child: Container(height: 37, child: VerticalDivider(color: Theme.of(context).disabledColor.withOpacity(.4), thickness: 1,),
                    ),
                  ),
                  Positioned(
                    top: 32,
                    left: MediaQuery.of(context).size.width / 2 - 6,
                    child: Container(height: 34, child: Icon(Icons.arrow_forward_ios, size: 12, color: Theme.of(context).disabledColor.withOpacity(.4),),
                    ),
                  ),

                ],
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                child: LaundryTitleWidget(titleName: 'address'),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              AddressViewLaundry(),


              SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
              Padding(
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                child: LaundryTitleWidget(titleName: '${'order_note_instructions'.tr}:'),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                      borderSide: BorderSide(
                        color: Theme.of(context).disabledColor.withOpacity(.4),
                      ),
                    ),
                  ),
                  maxLines: 6,
                ),
              ),

              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
              CustomButton(
                onPressed: () {},
                buttonText: 'next'.tr,
                margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                radius: Dimensions.RADIUS_DEFAULT,
                backgroundColor: Theme.of(context).primaryColor,
                fontColor: Theme.of(context).textTheme.bodyLarge.color,
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),

            ],
          ),
        ),


      );
    });
  }
}



