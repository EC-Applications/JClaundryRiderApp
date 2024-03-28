

import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_service_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_service_list_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/helper/price_converter.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/add_remove_widget.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaundryItemWidget extends StatefulWidget {

  @override
  State<LaundryItemWidget> createState() => _LaundryItemWidgetState();
}

class _LaundryItemWidgetState extends State<LaundryItemWidget> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaundryServiceListController>(builder: (serviceListController) {
      return GetBuilder<LaundryServiceController>(builder: (serviceController) {
        return GetBuilder<LaundryCartController>(builder: (cartController) {
          return GetBuilder<OrderController>(builder: (orderController) {
            print('cartController.cartList.length ${cartController.cartList.length}');
            print('cartController.cartList ${cartController.cartList[0].items[0].toJson()}');
            
            return cartController.cartList != null ? cartController.cartList.length > 0 ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartController.cartList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Text(
                            '${serviceController.getServiceName(cartController.cartList[index].servicesId)}',
                            style: robotoBold.copyWith(
                                color: Theme.of(context).textTheme.bodyLarge.color,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartController.cartList[index].items.length,
                          itemBuilder: (context, index1) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                          child: Text(
                                            '${cartController.cartList[index].items[index1].name}',
                                            style: robotoBold.copyWith(
                                              color: Theme.of(context).textTheme.bodyLarge.color,
                                              fontSize: Dimensions.FONT_SIZE_LARGE,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                          child: RichText(text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: '${'quantity'.tr}: ',
                                                  style: robotoRegular.copyWith(
                                                      color: Theme.of(context).disabledColor,
                                                      fontSize: Dimensions.FONT_SIZE_DEFAULT
                                                  )
                                              ),

                                              TextSpan(
                                                text: '${cartController.cartList[index].items[index1].quantity}',
                                                style: robotoRegular.copyWith(
                                                  color: Theme.of(context).disabledColor,
                                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                                ),
                                              ),
                                            ],
                                          ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                                      ],
                                    ),
                                    Spacer(),

                                    CustomContainer(
                                      text: '${cartController.cartList[index].items[index1].quantity}',
                                      isArrowDownIconShow: orderController.isEdited,
                                      onTap: () {
                                        {

                                          if(orderController.isEdited) Get.defaultDialog(
                                            actions: [
                                              TextButton(
                                                onPressed: () => Get.back(),
                                                child: Text('ok'.tr, style: robotoMedium.copyWith(color: Theme.of(context).disabledColor),),
                                              ),
                                            ],
                                            title: 'edit_quantity'.tr,
                                            content: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                AddRemoveWidget(imgUrl: Images.remove, onTap: () {
                                                  if(cartController.cartList.length > index) {
                                                    cartController.setQuantity(cartController.cartList[index].items[index1].laundryItemId, cartController.cartList[index].servicesId, false);

                                                  }
                                                },),
                                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                                                GetBuilder<LaundryCartController>(builder: (lanController) {
                                                  if(lanController.cartList.length > index) {
                                                    if (lanController.cartList[index].items.length > index1) {
                                                      return Text(lanController.getQuantity(lanController.cartList[index].items[index1].laundryItemId, lanController.cartList[index].servicesId).toString(),
                                                        style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),);
                                                    }else {
                                                      Get.back();
                                                      return Text('0');
                                                    }
                                                  }else {
                                                    Get.back();
                                                    return Text('0');
                                                  }
                                                }),
                                                SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                                                AddRemoveWidget(imgUrl: Images.add, onTap: () {
                                                  if(cartController.cartList.length > index) {
                                                    if (cartController.getQuantity(cartController.cartList[index].items[index1].laundryItemId, cartController.cartList[index].servicesId) == 0) {
                                                      cartController.addToCart(cartController.cartList[index].servicesId, cartController.cartList[index].items[index1].laundryItemId, 1, cartController.cartList[index].items[index1].price, cartController.cartList[index].items[index1].name);
                                                    } else {
                                                      cartController.setQuantity(cartController.cartList[index].items[index1].laundryItemId, cartController.cartList[index].servicesId, true);
                                                    }
                                                  }
                                                },),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                    Padding(
                                      padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
                                      child: CustomContainer(
                                        text: '${PriceConverter.convertPrice(cartController.cartList[index].items[index1].price.toDouble())}',
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                    
                        cartController.cartList[index].items[index1].addons != null &&
                        cartController.cartList[index].items[index1].addons.length > 0 ?
                         
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(
                              'Addons',
                              style: robotoBold.copyWith(
                                  color: Theme.of(context).textTheme.bodyMedium.color,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                                                      ),
                            ),
                            SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),
                            
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cartController.cartList[index].items[index1].addons.length,
                              itemBuilder: (context, index2) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                              child: Text(
                                                '${cartController.cartList[index].items[index1].addons[index2].name}',
                                                style: robotoBold.copyWith(
                                                  color: Theme.of(context).textTheme.bodyLarge.color,
                                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                              child: RichText(text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: '${'quantity'.tr}: ',
                                                      style: robotoRegular.copyWith(
                                                          color: Theme.of(context).disabledColor,
                                                          fontSize: Dimensions.FONT_SIZE_DEFAULT
                                                      )
                                                  ),

                                                  TextSpan(
                                                    text: '${cartController.cartList[index].items[index1].addons[index2].qty}',
                                                    style: robotoRegular.copyWith(
                                                      color: Theme.of(context).disabledColor,
                                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                                          ],
                                        ),
                                        Spacer(),

                                        CustomContainer(
                                          text: '${cartController.cartList[index].items[index1].addons[index2].qty}',
                                          isArrowDownIconShow: orderController.isEdited,
                                          onTap: () {
                                            {

                                              if(orderController.isEdited) Get.defaultDialog(
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Get.back(),
                                                    child: Text('ok'.tr, style: robotoMedium.copyWith(color: Theme.of(context).disabledColor),),
                                                  ),
                                                ],
                                                title: 'edit_quantity'.tr,
                                                content: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [

                                                    AddRemoveWidget(imgUrl: Images.remove, onTap: () {
                                                      if(cartController.cartList.length > index) {
                                                     cartController.setQuantityAddon(cartController.cartList[index].items[index1].laundryItemId, cartController.cartList[index].servicesId,cartController.cartList[index].items[index1].addons[index2].id, false);
                                                         }

                                                    },),
                                                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                                                    GetBuilder<LaundryCartController>(builder: (lanController) {

                                                      if(lanController.cartList.length > index) {
                                                        if (lanController.cartList[index].items.length > index1) {
                                                          return Text(lanController.getQuantityAddon(lanController.cartList[index].items[index1].addons[index2].id,lanController.cartList[index].items[index1].laundryItemId, lanController.cartList[index].servicesId).toString(),
                                                            style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),);
                                                        }else {
                                                          Get.back();
                                                          return Text('0');
                                                        }

                                                      }else {
                                                        Get.back();
                                                        return Text('0');
                                                      }


                                                    }),
                                                    SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                                                    AddRemoveWidget(imgUrl: Images.add, onTap: () {
                                                      if(cartController.cartList.length > index) {
                                                        if (cartController.getQuantityAddon(cartController.cartList[index].items[index1].addons[index2].id,cartController.cartList[index].items[index1].laundryItemId, cartController.cartList[index].servicesId) == 0) {
                                                          cartController.addToCart(cartController.cartList[index].servicesId, cartController.cartList[index].items[index1].laundryItemId, 1, cartController.cartList[index].items[index1].price, cartController.cartList[index].items[index1].name,addon_id:cartController.cartList[index].items[index1].addons[index2].id ,addon_quantity:cartController.cartList[index].items[index1].addons[index2].qty );
                                                        } else {
                                                          cartController.setQuantityAddon(cartController.cartList[index].items[index1].laundryItemId, cartController.cartList[index].servicesId,cartController.cartList[index].items[index1].addons[index2].id, true);
                                                        }
                                                      }

                                                    },),
                                                  ],
                                                ),


                                              );


                                            }
                                          },
                                        ),
                                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                        Padding(
                                          padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_DEFAULT),
                                          child: CustomContainer(
                                            text: '${PriceConverter.convertPrice(cartController.cartList[index].items[index1].addons[index2].price.toDouble())}',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                        
                        :SizedBox(),
                      
                        
                              ],
                            );
                          },
                        ),
                        (index == cartController.cartList.length - 1) ? SizedBox() : Divider(thickness: 1),

                      ],
                    );
                  },
                ),





              ],
            )  : Center(child: Text('no_data_found'.tr),) : Center(child: CircularProgressIndicator(),);
          });
        });
      });
    });
  }
}
