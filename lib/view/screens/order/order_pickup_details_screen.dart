import 'package:dotted_border/dotted_border.dart';
import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/data/model/body/laundry_place_order_body.dart';
import 'package:efood_multivendor_driver/data/model/body/pick_order_map_body.dart';
import 'package:efood_multivendor_driver/data/model/body/update_status_body.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/helper/price_converter.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/app_constants.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/confirmation_dialog.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:efood_multivendor_driver/view/base/Custom_button_sec.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/base/custom_text_field.dart';
import 'package:efood_multivendor_driver/view/screens/dashboard/dashboard_screen.dart';
import 'package:efood_multivendor_driver/view/screens/home/widget/custom_dotted_line.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/laundry_item_view.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/order_details_view.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/slider_button.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/verify_delivery_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher_string.dart';


import 'widget/generate_invoice.dart';


import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart' as esc;
import 'package:esc_pos_printer/esc_pos_printer.dart';



class OrderPickupDetailsScreen extends StatefulWidget {
  final OrderList orderList;
  OrderPickupDetailsScreen({@required this.orderList});

  @override
  State<OrderPickupDetailsScreen> createState() =>
      _OrderPickupDetailsScreenState();
}

class _OrderPickupDetailsScreenState extends State<OrderPickupDetailsScreen> {
  bool isDelivered = false;

  TextEditingController cancelController = TextEditingController();
    TextEditingController customReasonController = TextEditingController();
    TextEditingController returnReasonController = TextEditingController();

  loadData() async {
    await Get.find<OrderController>()
        .getOrderDetails(widget.orderList.id, notify: false);
    if (Get.find<OrderController>().laundryOrderDetailsModel != null) {
      Get.find<LaundryCartController>().setExistingItemsInCart(
          Get.find<OrderController>().convertToCartList(
              Get.find<OrderController>().laundryOrderDetailsModel),
          notify: false);
      Get.find<OrderController>().setOrderPickedValue(false, notify: false);
      Get.find<OrderController>().setMarkAsPickedValue(false, notify: false);
      Get.find<OrderController>().setEditedValue(false, notify: false);
      Get.find<OrderController>().setOrderList(widget.orderList, notify: false);
      Get.find<LaundryCartController>().setDeliveryFee(
          double.parse(Get.find<OrderController>()
              .laundryOrderDetailsModel
              .deliveryCharge),
          notify: false);
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderController = Get.find<OrderController>();
    // final cartController = Get.find<LaundryCartController>();
    // if (orderController.laundryOrderDetailsModel != null) {
    //   cartController.setExistingItemsInCart(orderController.convertToCartList(orderController.laundryOrderDetailsModel));
    //   print('test');
    //   cartController.setDeliveryFee(double.parse(orderController.laundryOrderDetailsModel.deliveryCharge));
    // }
    return GetBuilder<AuthController>(builder: (authController) {
      return GetBuilder<LaundryCartController>(builder: (cartController) {
        return GetBuilder<OrderController>(builder: (orderController) {
          return orderController.isLoadingLocation
              ? Scaffold(body: Center(child: CircularProgressIndicator()))
              : orderController.laundryOrderDetailsModel != null
                  ? Scaffold(
                      backgroundColor: Theme.of(context).cardColor,
                      appBar: CustomAppBar(
                        title: orderController
                                    .laundryOrderDetailsModel.orderStatus ==
                                AppConstants.OUT_FOR_PICKUP
                            ? !orderController.isEdited
                                ? 'order_details'.tr
                                : 'edit_order_details'.tr
                            : orderController.checkPickUpDeliveryStatus(
                                    orderController
                                        .laundryOrderDetailsModel.orderStatus)
                                ? 'order_pickup_details'.tr
                                : 'order_delivery_details'.tr,
                        onBackPressed: () {
                          // cartController.clearCart();
                          Get.offNamed(RouteHelper.getInitialRoute());
                        },
                      ),
                      body: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                              vertical: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Column(
                            children: [
                              //order details
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              OrderDetailsView(
                                orderDetailsModel:
                                    orderController.laundryOrderDetailsModel,
                              ),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_LARGE,
                              ),

                              //begin pickup button
                              (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.PENDING ||
                                      orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.CONFIRMED)
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom:
                                              Dimensions.PADDING_SIZE_LARGE),
                                      child: orderController.isLoadingLocation
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : CustomButton(
                                              buttonText: 'begin_pickup'.tr,
                                              backgroundColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  .color,
                                              fontColor:
                                                  Theme.of(context).cardColor,
                                              radius: Dimensions.RADIUS_DEFAULT,
                                              onPressed: () async {
                                                await orderController
                                                    .getCurrentLocation();
                                                if (orderController
                                                    .isLocationPermission) {
                                                  await orderController
                                                      .getPickOrderRoute(
                                                    PickOrderMapBody(
                                                      pickupCoordinates: [
                                                        orderController
                                                            .position.latitude,
                                                        orderController
                                                            .position.longitude
                                                      ],
                                                      destinationCoordinates: [
                                                        orderController
                                                            .laundryOrderDetailsModel
                                                            .pickupCoordinates
                                                            .coordinates[1],
                                                        orderController
                                                            .laundryOrderDetailsModel
                                                            .pickupCoordinates
                                                            .coordinates[0]
                                                      ],
                                                    ),
                                                    _callBack,
                                                    orderController
                                                        .laundryOrderDetailsModel,
                                                  );
                                                  if (orderController
                                                      .checkPickUpDeliveryStatus(
                                                          orderController
                                                              .laundryOrderDetailsModel
                                                              .orderStatus)) {
                                                    Get.toNamed(
                                                        RouteHelper
                                                            .getPickUpRoute(
                                                                widget
                                                                    .orderList),
                                                        arguments: false);
                                                  } else {
                                                    Get.offNamed(RouteHelper
                                                        .getInitialRoute());
                                                  }
                                                }
                                              },
                                            ),
                                    )
                                  : SizedBox(),

                              //call customer button
                              (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.PENDING ||
                                      orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.CONFIRMED ||
                                      orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.OUT_FOR_DELIVERY ||
                                      orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.READY_FOR_DELIVERY)
                                  ? CustomButton(
                                      buttonText: 'call_customer'.tr,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      fontColor: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          .color,
                                      radius: Dimensions.RADIUS_DEFAULT,
                                      onPressed: () async {
                                        if (await canLaunchUrlString(
                                            'tel:${orderController.checkPickUpDeliveryStatus(orderController.laundryOrderDetailsModel.orderStatus) ? orderController.laundryOrderDetailsModel.pickupAddress.contactPersonNumber : orderController.laundryOrderDetailsModel.destinationAddress.contactPersonNumber}')) {
                                          launchUrlString(
                                              'tel:${orderController.checkPickUpDeliveryStatus(orderController.laundryOrderDetailsModel.orderStatus) ? orderController.laundryOrderDetailsModel.pickupAddress.contactPersonNumber : orderController.laundryOrderDetailsModel.destinationAddress.contactPersonNumber}');
                                        } else {
                                          showCustomSnackBar(
                                              '${'can_not_launch'.tr} ${orderController.checkPickUpDeliveryStatus(orderController.laundryOrderDetailsModel.orderStatus) ? orderController.laundryOrderDetailsModel.pickupAddress.contactPersonNumber : orderController.laundryOrderDetailsModel.destinationAddress.contactPersonNumber}');
                                        }
                                      },
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_LARGE,
                              ),

                              //  //marks as picked note
                              // Container(
                              //    alignment: Alignment.center,
                              //    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                              //    decoration: BoxDecoration(
                              //      color: Theme.of(context).primaryColor.withOpacity(.2),
                              //      borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                              //    ),
                              //    child: Row(
                              //      children: [
                              //        Icon(Icons.error, color: Theme.of(context).primaryColor, size: 24,),
                              //        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                              //        Expanded(
                              //          child: RichText(text: TextSpan(
                              //            children: [
                              //              TextSpan(
                              //                text: '${'note'.tr}: ',
                              //                style: robotoBold.copyWith(
                              //                  fontSize: Dimensions.FONT_SIZE_LARGE,
                              //                  color: Theme.of(context).textTheme.bodyLarge.color,
                              //                ),
                              //              ),
                              //
                              //              TextSpan(
                              //                text: 'this_is_a_booking_order_add_items_to_this_order_by_clicking_the_button_below'.tr,
                              //                style: robotoRegular.copyWith(
                              //                  fontSize: Dimensions.FONT_SIZE_LARGE,
                              //                  color: Theme.of(context).textTheme.bodyLarge.color,
                              //                ),
                              //              ),
                              //            ]
                              //          ),
                              //            maxLines: 2,
                              //            overflow: TextOverflow.ellipsis,
                              //          ),
                              //        ),
                              //        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                              //      ],
                              //    ),
                              //  ),
                              //  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),

                              //laundry items
                              (orderController.laundryOrderDetailsModel
                                          .orderStatus ==
                                      AppConstants.OUT_FOR_PICKUP)
                                  ? Column(
                                      children: [
                                        LaundryItemView(),
                                        SizedBox(
                                          height: Dimensions.PADDING_SIZE_LARGE,
                                        ),

                                        //add more items
                                        if (orderController.isEdited)
                                          InkWell(
                                            onTap: () {
                                              orderController
                                                  .setSelectedIndex(0);
                                              // if(Get.find<LaundryServiceController>().serviceList != null) {
                                              //   Get.find<LaundryServiceListController>().getServiceItemList(serviceId: Get.find<LaundryServiceController>().serviceList[0].id);
                                              // }
                                              // cartController.updateQuantity(cartController.cartList);
                                              Get.toNamed(RouteHelper
                                                  .getAddItemRoute());
                                            },
                                            child: DottedBorder(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              radius: Radius.circular(
                                                  Dimensions.RADIUS_DEFAULT),
                                              padding: EdgeInsets.all(Dimensions
                                                  .PADDING_SIZE_LARGE),
                                              borderType: BorderType.RRect,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 28,
                                                    width: 28,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .RADIUS_DEFAULT),
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge
                                                                  .color,
                                                          width: 2,
                                                        )),
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 24,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          .color,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_DEFAULT,
                                                  ),
                                                  Text(
                                                    orderController.markAsPicked
                                                        ? 'add_items_to_order'
                                                            .tr
                                                        : 'add_more_items'.tr,
                                                    style: robotoBold.copyWith(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_EXTRA_LARGE,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge
                                                          .color,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (orderController.isEdited)
                                          SizedBox(height: 40),

                                        //total amount
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_DEFAULT,
                                              vertical: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .RADIUS_DEFAULT),
                                              border: Border.all(
                                                color: Theme.of(context)
                                                    .disabledColor
                                                    .withOpacity(.5),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Theme.of(context)
                                                        .disabledColor
                                                        .withOpacity(.7),
                                                    blurRadius: 5,
                                                    blurStyle:
                                                        BlurStyle.normal),
                                              ]),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'total_amount'.tr,
                                                      style:
                                                          robotoBold.copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_EXTRA_LARGE,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            .color,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: Dimensions
                                                          .PADDING_SIZE_EXTRA_SMALL,
                                                    ),
                                                    Text(
                                                      'inclusive_of_taxes_and_delivery'
                                                          .tr,
                                                      style:
                                                          robotoMedium.copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_SMALL,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            .color
                                                            .withOpacity(.5),
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CustomDottedLine(
                                                  dashGapLength: 0),
                                              Flexible(
                                                child: Text(
                                                  '${PriceConverter.convertPrice(cartController.totalPrice)}',
                                                  style: robotoBold.copyWith(
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_EXTRA_LARGE,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        .color,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: Dimensions.PADDING_SIZE_LARGE,
                                        ),
                                      ],
                                    )
                                  : SizedBox(),

                              (orderController.laundryOrderDetailsModel
                                          .orderStatus ==
                                      AppConstants.OUT_FOR_PICKUP)
                                  ? SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_LARGE,
                                    )
                                  : SizedBox(),

                              // -----------------------------------------------
                              //mark as picked button
                              (orderController.laundryOrderDetailsModel
                                          .orderStatus ==
                                      AppConstants.OUT_FOR_PICKUP)
                                  ? CustomButton(
                                      buttonText: orderController.isEdited
                                          ? 'save_and_update'.tr
                                          : 'mark_as_picked'.tr,
                                      backgroundColor:
                                          orderController.markAsPicked
                                              ? Theme.of(context)
                                                  .disabledColor
                                                  .withOpacity(.2)
                                              : Theme.of(context).primaryColor,
                                      fontColor: orderController.markAsPicked
                                          ? Theme.of(context).disabledColor
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              .color,
                                      radius: Dimensions.RADIUS_DEFAULT,
                                      isLoader: orderController.isEdited &&
                                          orderController.isLoading,
                                      onPressed: () async {
                                        if (orderController.isEdited) {
                                          await orderController.updateOrder(
                                              LaundryPlaceOrderBody(
                                                token:
                                                    Get.find<AuthController>()
                                                        .getUserToken(),
                                                orderId: orderController
                                                    .laundryOrderDetailsModel.id
                                                    .toString(),
                                                // cart: cartController.getCartList(),
                                                cart: cartController.cartList,
                                              ),
                                              _callBack);
                                          orderController.setEditedValue(false);
                                        } else {
                                          Get.dialog(ConfirmationDialog(
                                              icon: Images.warning,
                                              description:
                                                  'you_want_to_pickup_this_order'
                                                      .tr,
                                              onYesPressed: () async {

                                                Navigator.pop(context);
                                                await orderController
                                                    .updateOrderStatus(
                                                  UpdateStatusBody(
                                                      orderId: orderController
                                                          .orderListModel.id
                                                          .toString(),
                                                      status: AppConstants
                                                          .PICKED_UP,
                                                      token: Get.find<
                                                              AuthController>()
                                                          .getUserToken()),
                                                  _callBack,
                                                );
                                                await orderController
                                                    .getOrderDetails(orderController
                                                        .laundryOrderDetailsModel
                                                        .id);
                                                orderController
                                                    .setMarkAsPickedValue(true);
                                                setState(() {});
                                                await orderController.printinoivce();

                                              }));
                                    
                                        }
                                      },
                                    )
                                  : SizedBox(),
                              (orderController.laundryOrderDetailsModel
                                          .orderStatus ==
                                      AppConstants.OUT_FOR_PICKUP)
                                  ? SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT,
                                    )
                                  : SizedBox(),

                        (orderController.laundryOrderDetailsModel
                                                  .orderStatus ==
                                              AppConstants.OUT_FOR_PICKUP ||
                                          orderController
                                                  .laundryOrderDetailsModel
                                                  .orderStatus ==
                                              AppConstants.OUT_FOR_DELIVERY)
                                      ? !orderController.isEdited
                                          ? orderController.takePicLoading
                                              ? const Center(
                                                  child:CircularProgressIndicator(),
                                                )
                                              : SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                child: CustomButtonSec(
                                                  
                                                    bgColor: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        .color,
                                                    btntext: 'take_picture'.tr,
                                                    fontColor: Theme.of(context)
                                                        .cardColor,
                                                    bordercolor: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        .color,
                                                    callback: () async {
                                                      await orderController
                                                          .captureImage();
                                                      await orderController
                                                          .uploadPicture(
                                                              orderController
                                                                  .laundryOrderDetailsModel
                                                                  .id,
                                                              authController
                                                                  .getUserToken());
                                                    },
                                                  ),
                                              )
                                          : SizedBox()

                                      : SizedBox(),
                                       (orderController.laundryOrderDetailsModel
                                          .orderStatus ==
                                      AppConstants.OUT_FOR_PICKUP ||
                                          orderController
                                                  .laundryOrderDetailsModel
                                                  .orderStatus ==
                                              AppConstants.OUT_FOR_DELIVERY)
                                  ? SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT,
                                    )
                                  : SizedBox(),
                              //take picture button
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   (orderController.laundryOrderDetailsModel
//                                                   .orderStatus ==
//                                               AppConstants.OUT_FOR_PICKUP ||
//                                           orderController
//                                                   .laundryOrderDetailsModel
//                                                   .orderStatus ==
//                                               AppConstants.OUT_FOR_DELIVERY)
//                                       ? !orderController.isEdited
//                                           ? orderController.takePicLoading
//                                               ? const Center(
//                                                   child:
//                                                       CircularProgressIndicator(),
//                                                 )
//                                               : CustomButtonSec(
//                                                   bgColor: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyLarge
//                                                       .color,
//                                                   btntext: 'take_picture'.tr,
//                                                   fontColor: Theme.of(context)
//                                                       .cardColor,
//                                                   bordercolor: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyLarge
//                                                       .color,
//                                                   callback: () async {
//                                                     await orderController
//                                                         .captureImage();
//                                                     await orderController
//                                                         .uploadPicture(
//                                                             orderController
//                                                                 .laundryOrderDetailsModel
//                                                                 .id,
//                                                             authController
//                                                                 .getUserToken());
//                                                   },
//                                                 )
//                                           : SizedBox()
//                                       : SizedBox(),
//                                   (orderController.laundryOrderDetailsModel
//                                                   .orderStatus ==
//                                               AppConstants.OUT_FOR_PICKUP ||
//                                           orderController
//                                                   .laundryOrderDetailsModel
//                                                   .orderStatus ==
//                                               AppConstants.OUT_FOR_DELIVERY)
//                                       ? !orderController.isEdited
//                                           ? orderController.takePicLoading
//                                               ? const Center(
//                                                   child:
//                                                       CircularProgressIndicator(),
//                                                 )
//                                               : CustomButtonSec(
//                                                   bgColor: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyLarge
//                                                       .color,
//                                                   btntext: 'Print Invoice'.tr,
//                                                   fontColor: Theme.of(context)
//                                                       .cardColor,
//                                                   bordercolor: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyLarge
//                                                       .color,
//                                                   callback:
//                                                    () async {
//                                                     await orderController.printinoivce();
//                 // await Printing.layoutPdf( 
//                 //   format: PdfPageFormat.roll57,
//                 //   onLayout: (PdfPageFormat format) async {
//                 //   // Generate your PDF here
//                 //   final pdf = await generatePdf(PdfPageFormat.roll57,orderDetailsModel: orderController.laundryOrderDetailsModel);
//                 //   return pdf;
//                 // });
//                 print("success");
//               },
// //                               () async {
// //   await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
// //     // Choose the desired paper size for photos, for example, letter size (8.5 x 11 inches)
// //     final PdfPageFormat photoFormat = PdfPageFormat(3.5 * PdfPageFormat.inch,
// //         6 * PdfPageFormat.inch, marginAll: 0);

// //     // Generate your PDF using the selected format
// //     final pdf = await generatePdf(photoFormat, orderDetailsModel: orderController.laundryOrderDetailsModel);
// //     return pdf;
// //   });
// //   print("success");
// // },
//                    )
//                                           : SizedBox()
//                                       : SizedBox(),
//                                 ],
//                               ),
                              
//                               (orderController.laundryOrderDetailsModel
//                                               .orderStatus ==
//                                           AppConstants.OUT_FOR_PICKUP ||
//                                       orderController.laundryOrderDetailsModel
//                                               .orderStatus ==
//                                           AppConstants.OUT_FOR_DELIVERY)
//                                   ? SizedBox(
//                                       height: Dimensions.PADDING_SIZE_LARGE,
//                                     )
//                                   : SizedBox(),

// -------------------------------------------
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.OUT_FOR_PICKUP)
                                      ? !orderController.isEdited
                                          ? CustomButtonSec(
                                              bgColor: Colors.transparent,
                                              bordercolor: Colors.red,
                                              btntext: "Deferred ",
                                              fontColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  .color,
                                              callback: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                       titlePadding: EdgeInsets.zero,
                                                       title:  Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 4.0,
              ),
              child: Text('Please select reason for Delivery deferral'.tr),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.highlight_remove_sharp,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                          customReasonController,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .RADIUS_SMALL),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                                width: 1),
                                                          ),
                                                          hintText:
                                                              'Enter_Deferred_reason'
                                                                  .tr,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_DEFAULT,
                                                      ),
                                                      CustomButton(
                                                        buttonText: 'submit'.tr,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        fontColor:
                                                            Theme.of(context)
                                                                .cardColor,
                                                        radius: Dimensions
                                                            .RADIUS_DEFAULT,
                                                        onPressed: () async {
                                                          if (customReasonController
                                                              .text
                                                              .isNotEmpty) {
                                                            Navigator.pop(
                                                                context);
                                                            Get.offNamed(RouteHelper
                                                                .getInitialRoute());
                                                            await orderController
                                                                .updateOrderStatus(
                                                              UpdateStatusBody(
                                                                  orderId: orderController
                                                                      .orderListModel
                                                                      .id
                                                                      .toString(),
                                                                  status: AppConstants
                                                                      .DEFERRED,
                                                                  token: Get.find<
                                                                          AuthController>()
                                                                      .getUserToken(),
                                                                 deferred_reason: 
                                                                      customReasonController
                                                                          .text),
                                                              _callBack,
                                                            );
                                                          } else {
                                                            showCustomSnackBar(
                                                                'Enter_Deferred_reason'
                                                                    .tr,
                                                            );
                                                        
                                                        }
                                                        }
                                                      ),
                                                    ],
                                                  ),
        ],
        )
                                                    )
                                                  );
                                              }
                                            )
                                          : SizedBox()
                                      : SizedBox(),

                                  (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.OUT_FOR_PICKUP)
                                      ? !orderController.isEdited
                                          ? CustomButtonSec(
                                              bgColor: Colors.transparent,
                                              bordercolor: Colors.red,
                                              btntext: "Cancel Pickup",
                                              fontColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  .color,
                                              callback: () {
                                                Get.dialog(AlertDialog(
                                                  titlePadding: EdgeInsets.zero,
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Padding(
                                                        padding: const EdgeInsets
                                                                .only(
                                                            left: Dimensions
                                                                .PADDING_SIZE_DEFAULT,
                                                            top: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        child: Text(
                                                            'cancellation_reason'
                                                                .tr),
                                                      )),
                                                      IconButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          icon: Icon(
                                                            Icons
                                                                .highlight_remove_sharp,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor,
                                                          )),
                                                    ],
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            cancelController,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .RADIUS_SMALL),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                                width: 1),
                                                          ),
                                                          hintText:
                                                              'enter_cancellation_reason'
                                                                  .tr,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_DEFAULT,
                                                      ),
                                                      CustomButton(
                                                        buttonText: 'submit'.tr,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        fontColor:
                                                            Theme.of(context)
                                                                .cardColor,
                                                        radius: Dimensions
                                                            .RADIUS_DEFAULT,
                                                        onPressed: () async {
                                                          if (cancelController
                                                              .text
                                                              .isNotEmpty) {
                                                            Navigator.pop(
                                                                context);
                                                            Get.offNamed(RouteHelper
                                                                .getInitialRoute());
                                                            await orderController
                                                                .updateOrderStatus(
                                                              UpdateStatusBody(
                                                                  orderId: orderController
                                                                      .orderListModel
                                                                      .id
                                                                      .toString(),
                                                                  status: AppConstants
                                                                      .CANCELED,
                                                                  token: Get.find<
                                                                          AuthController>()
                                                                      .getUserToken(),
                                                                  cancelReason:
                                                                      cancelController
                                                                          .text),
                                                              _callBack,
                                                            );
                                                          } else {
                                                            showCustomSnackBar(
                                                                'enter_cancellation_reason'
                                                                    .tr,
                                                                isError: true);
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                              },
                                            )
                                          : SizedBox()
                                      : SizedBox(),
                                      
                                ],
                              ),

                              (orderController.laundryOrderDetailsModel
                                          .orderStatus ==
                                      AppConstants.OUT_FOR_DELIVERY)
                                  ? SizedBox()
                                  : SizedBox(
                                      height: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                              // -------------Out for delivery comment
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [

                                  //defer pickup button
                                  (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.OUT_FOR_DELIVERY)
                                      ? !orderController.isEdited
                                          ? CustomButtonSec(
                                              bgColor: Colors.transparent,
                                              bordercolor: Colors.red,
                                              btntext: "Deferred ",
                                              fontColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  .color,
                                              callback: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                       titlePadding: EdgeInsets.zero,
                                                       title:  Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 4.0,
              ),
              child: Text('Please select reason for Delivery deferral'.tr),
            ),
          ),
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.highlight_remove_sharp,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                          customReasonController,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .RADIUS_SMALL),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                                width: 1),
                                                          ),
                                                          hintText:
                                                              'Enter_Deferred_reason'
                                                                  .tr,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_DEFAULT,
                                                      ),
                                                      CustomButton(
                                                        buttonText: 'submit'.tr,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        fontColor:
                                                            Theme.of(context)
                                                                .cardColor,
                                                        radius: Dimensions
                                                            .RADIUS_DEFAULT,
                                                        onPressed: () async {
                                                          if (customReasonController
                                                              .text
                                                              .isNotEmpty) {
                                                            Navigator.pop(
                                                                context);
                                                            Get.offNamed(RouteHelper
                                                                .getInitialRoute());
                                                            await orderController
                                                                .updateOrderStatus(
                                                              UpdateStatusBody(
                                                                  orderId: orderController
                                                                      .orderListModel
                                                                      .id
                                                                      .toString(),
                                                                  status: AppConstants
                                                                      .DEFERRED,
                                                                  token: Get.find<
                                                                          AuthController>()
                                                                      .getUserToken(),
                                                                 deferred_reason: 
                                                                      customReasonController
                                                                          .text),
                                                              _callBack,
                                                            );
                                                          } else {
                                                            showCustomSnackBar(
                                                                'Enter_Deferred_reason'
                                                                    .tr,
                                                            );
                                                        
                                                        }
                                                        }
                                                      ),
                                                    ],
                                                  ),
        ],
        )
                                                    )
                                                  );
                                              }
                                            )
                                          : SizedBox()
                                      : SizedBox(),
                                  (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.OUT_FOR_DELIVERY)
                                      ? !orderController.isEdited
                                          ? CustomButtonSec(
                                              bgColor: Colors.transparent,
                                              bordercolor: Colors.red,
                                              btntext: "Return",
                                              fontColor: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  .color,
                                              callback: () {
                                                Get.dialog(AlertDialog(
                                                  titlePadding: EdgeInsets.zero,
                                                  title: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Padding(
                                                        padding: const EdgeInsets
                                                                .only(
                                                            left: Dimensions
                                                                .PADDING_SIZE_DEFAULT,
                                                            top: Dimensions
                                                                .PADDING_SIZE_SMALL),
                                                        child: Text(
                                                            'Return_reason'
                                                                .tr),
                                                      )),
                                                      IconButton(
                                                          onPressed: () =>
                                                              Get.back(),
                                                          icon: Icon(
                                                            Icons
                                                                .highlight_remove_sharp,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor,
                                                          )),
                                                    ],
                                                  ),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextField(
                                                        controller:
                                                            cancelController,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .RADIUS_SMALL),
                                                            borderSide: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .disabledColor,
                                                                width: 1),
                                                          ),
                                                          hintText:
                                                              'enter_Return_reason'
                                                                  .tr,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .PADDING_SIZE_DEFAULT,
                                                      ),
                                                      CustomButton(
                                                        buttonText: 'submit'.tr,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        fontColor:
                                                            Theme.of(context)
                                                                .cardColor,
                                                        radius: Dimensions
                                                            .RADIUS_DEFAULT,
                                                        onPressed: () async {
                                                          if (cancelController
                                                              .text
                                                              .isNotEmpty) {
                                                            Navigator.pop(
                                                                context);
                                                            Get.offNamed(RouteHelper
                                                                .getInitialRoute());
                                                            await orderController
                                                                .updateOrderStatus(
                                                              UpdateStatusBody(
                                                                  orderId: orderController
                                                                      .orderListModel
                                                                      .id
                                                                      .toString(),
                                                                  status: AppConstants
                                                                      .RETURNED,
                                                                  token: Get.find<
                                                                          AuthController>()
                                                                      .getUserToken(),
                                                                  returned_reason: returnReasonController
                                                                          .text),
                                                              _callBack,
                                                            );
                                                          } else {
                                                            showCustomSnackBar(
                                                                'enter_Return_reason'
                                                                    .tr,
                                                                isError: true);
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                              },
                                            )
                                          : SizedBox()
                                      : SizedBox(),
                                ],
                              ),

                              //  (orderController.laundryOrderDetailsModel.orderStatus == AppConstants.OUT_FOR_DELIVERY) ? SizedBox() : SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                              SizedBox(
                                height: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                              //delivery swipe button
                              (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.OUT_FOR_DELIVERY ||
                                      orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.READY_FOR_DELIVERY)
                                  ? SliderButton(
                                      label: Text(
                                        (orderController
                                                    .laundryOrderDetailsModel
                                                    .orderStatus ==
                                                AppConstants.READY_FOR_DELIVERY)
                                            ? 'out_for_delivery'.tr
                                            : "deliver_order".tr,
                                        style: robotoBold.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_LARGE,
                                          color: Theme.of(context).cardColor,
                                        ),
                                      ),
                                      action: () async {
                                        debugPrint(
                                            '----------------------> orderController.laundryOrderDetailsModel.orderStatus ${orderController.laundryOrderDetailsModel.orderStatus}');
                                        if (orderController
                                                .laundryOrderDetailsModel
                                                .orderStatus ==
                                            AppConstants.READY_FOR_DELIVERY) {
                                          debugPrint(
                                              '--------------> AppConstants.READY_FOR_DELIVERY ${AppConstants.READY_FOR_DELIVERY}}');
                                          await orderController
                                              .updateOrderStatus(
                                            UpdateStatusBody(
                                                orderId: orderController
                                                    .laundryOrderDetailsModel.id
                                                    .toString(),
                                                status: AppConstants
                                                    .OUT_FOR_DELIVERY,
                                                token:
                                                    Get.find<AuthController>()
                                                        .getUserToken()),
                                            _callBack,
                                          );

                                          await orderController.getOrderDetails(
                                              orderController
                                                  .laundryOrderDetailsModel.id);

                                          setState(() {});
                                        } else {
                                          await orderController.printinoivce();
                                          Get.bottomSheet(
                                            VerifyDeliverySheet(
                                              cod: true,
                                              orderAmount:
                                                  widget.orderList.orderAmount,
                                              onTap: () async {
                                                print(widget.orderList.orderAmount);
                                                Get.back();
                                                await orderController
                                                    .updateOrderStatus(
                                                  UpdateStatusBody(
                                                      orderId: orderController
                                                          .laundryOrderDetailsModel
                                                          .id
                                                          .toString(),
                                                      status: AppConstants
                                                          .DELIVERED,
                                                      token: Get.find<
                                                              AuthController>()
                                                          .getUserToken()),
                                                  _callBack,
                                                );
                                                await orderController
                                                    .getOrderDetails(orderController
                                                        .laundryOrderDetailsModel
                                                        .id);

                                                setState(() {
                                                  isDelivered = true;
                                                });
                                              },
                                            ),
                                            isScrollControlled: true,
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 24,
                                        color: Theme.of(context).cardColor,
                                      ),
                                      dismissThresholds: 0.5,
                                      dismissible: false,
                                      shimmer: true,
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      height: 60,
                                      buttonSize: 50,
                                      radius: 10,
                                      boxShadow: BoxShadow(blurRadius: 0),
                                      buttonColor:
                                          Theme.of(context).primaryColor,
                                      backgroundColor: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          .color,
                                      baseColor: Theme.of(context).primaryColor,
                                    )
                                  : SizedBox(),
                              (orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.OUT_FOR_DELIVERY ||
                                      orderController.laundryOrderDetailsModel
                                              .orderStatus ==
                                          AppConstants.READY_FOR_DELIVERY)
                                  ? SizedBox(
                                      height: Dimensions.PADDING_SIZE_LARGE,
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Scaffold(body: Center(child: CircularProgressIndicator()));
        });
      });
    });
  }

  void _callBack(bool isSuccess, String message, String orderId,
      {bool showSnackBar = true, bool isError = false}) {
    if (isSuccess) {
      if (showSnackBar) {
        showCustomSnackBar(message, isError: isError);
      }
    } else {
      showCustomSnackBar(message, isError: isError);
    }
  }
}


