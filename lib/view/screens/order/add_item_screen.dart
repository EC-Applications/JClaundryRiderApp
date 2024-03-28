
import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_service_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_service_list_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/config_model.dart';
import 'package:efood_multivendor_driver/helper/price_converter.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/product_view_laundry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemScreen extends StatelessWidget {
  loadData() async{
    await Get.find<LaundryServiceController>().getServiceList();
    if (Get.find<LaundryServiceController>().serviceList != null) {
      await Get.find<LaundryServiceListController>().getServiceItemList(serviceId: Get.find<LaundryServiceController>().serviceList[0].id);
      Get.find<LaundryServiceListController>().setServiceId(Get.find<LaundryServiceController>().serviceList[0].id);
    }

  }
  @override
  Widget build(BuildContext context) {
    loadData();
    BaseUrls _baseUrls = Get.find<SplashController>().configModel.baseUrls;
    return GetBuilder<LaundryCartController>(builder: (cartController) {
      return GetBuilder<LaundryServiceListController>(builder: (serviceListController) {
        return GetBuilder<LaundryServiceController>(builder: (serviceController) {
          return GetBuilder<OrderController>(builder: (orderController) {
            return Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              appBar: CustomAppBar(
                title: 'add_items_to_laundry'.tr,
              ),
              body: Column(
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),
                  serviceController.serviceList != null ? SizedBox(
                    height: 30,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                      physics: BouncingScrollPhysics(),
                      itemCount: serviceController.serviceList.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final service = serviceController.serviceList[index];
                        return InkWell(
                          onTap: () async{
                            orderController.setSelectedIndex(index);
                            serviceController.setServicesId(service.id);
                            await serviceListController.getServiceItemList(serviceId: service.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                                  color: orderController.selectedIndex == index ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                                  border: orderController.selectedIndex == index ? null : Border.all(color: Theme.of(context).textTheme.bodyLarge.color)
                              ),
                              child: Text('${serviceController.serviceList[index].name}', style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: orderController.selectedIndex == index ? Theme.of(context).cardColor : Theme.of(context).textTheme.bodyLarge.color),),
                            ),
                          ),
                        );
                      },
                    ),
                  ) : SizedBox(),

                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE,),

                  serviceListController.serviceItemList != null ? serviceListController.serviceItemList.length > 0 ? serviceListController.isLoading ? Center(child: CircularProgressIndicator()) : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemCount: serviceListController.serviceItemList.length,
                      itemBuilder: (context, index) {
                        final serviceItem = serviceListController.serviceItemList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
                          child: ProductViewLaundry(
                              servicesId: serviceController.servicesId,
                              laundryItemId: serviceItem.id,
                              imgUrl: '${_baseUrls.laundryItemsImageUrl}/${serviceItem.icon}',
                              productName: serviceItem.name,
                              actualPrice: serviceItem.price,
                              isFromCart: true,
                              discountedPrice: serviceListController.campaign != null ? serviceListController.campaign.price.toString() : "0",
                              isDiscounted: serviceListController.campaign!= null ? true : false,
                              percatage: serviceListController.campaign != null ? serviceListController.campaign.discount: 0,
                              addons : serviceItem.addons != null ? serviceItem.addons : null
                              
                            ),




//---------------------------------------------------Moiz Product View Laundry -----------------------------------------
                          // ProductViewLaundry(
                          //   servicesId: serviceController.serviceList[orderController.selectedIndex].id,
                          //   laundryItemId: serviceItem.id,
                          //   imgUrl: '${_baseUrls.laundryItemsImageUrl}/${serviceListController.serviceItemList[index].icon}',
                          //   productName: '${serviceListController.serviceItemList[index].name}',
                          //   productPrice: '${serviceListController.serviceItemList[index].price.toDouble()}',
                          // ),
                        );
                      },
                    ),
                  ) : Center(child: Text('no_data_found'.tr),) : Center(child: CircularProgressIndicator(),),

                ],
              ),

              bottomNavigationBar: Container(
                alignment: Alignment.center,
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).hintColor, spreadRadius: .4, blurRadius: 5),
                    ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(.1),
                                shape: BoxShape.circle
                            ),
                            child: Image.asset(Images.box, height: 32, width: 32, color: Theme.of(context).primaryColor,),
                          ),

                          SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'total'.tr,
                                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).textTheme.bodyLarge.color),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${cartController.totalItems} ${(cartController.totalItems == 0? 'item'.tr : 'items'.tr)}',
                                  style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),


                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'estimate'.tr,
                                  style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: Theme.of(context).textTheme.bodyLarge.color),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${PriceConverter.convertPrice(cartController.subTotalPrice)}',
                                  style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).primaryColor),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                    CustomButton(
                      onPressed: () {
                        if(orderController.markAsPicked) {
                          Get.toNamed(RouteHelper.getOrderDetailsRoute());
                        }else {
                          Get.back();
                        }

                      },
                      buttonText: 'next'.tr,
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                      radius: Dimensions.RADIUS_DEFAULT,
                      backgroundColor: Theme.of(context).primaryColor,
                      fontColor: Theme.of(context).textTheme.bodyLarge.color,
                    ),
                  ],
                ),
              ),
            );
          });
        });
      });
    });
  }
}
