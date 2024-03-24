import 'dart:async';

import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_notification_controller.dart';
import 'package:efood_multivendor_driver/controller/laundry_service_controller.dart';
import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/controller/profile_controller.dart';
import 'package:efood_multivendor_driver/controller/splash_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/no_data_screen.dart';
import 'package:efood_multivendor_driver/view/base/order_item_view.dart';
import 'package:efood_multivendor_driver/view/base/order_shimmer.dart';
import 'package:efood_multivendor_driver/view/base/paginated_list_view.dart';
import 'package:efood_multivendor_driver/view/screens/home/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();

  static Future<void> loadData() async {
    await Get.find<ProfileController>().getProfileOrderStatus();
    await Get.find<AuthController>().getProfile();
    await Get.find<OrderController>().getOrderList(1);
    await Get.find<LaundryServiceController>().getServiceList();
    await Get.find<LaundryNotificationController>().getNotificationList(1);
    Get.find<LaundryCartController>().setTax(Get.find<SplashController>().configModel.laundryTax);
  }
  
  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<OrderController>(builder: (orderController) {
      List<OrderList> _orderList = orderController.tabIndex == 0 ? orderController.pickUpOrderList : orderController.deliveryOrderList;
      return GetBuilder<AuthController>(builder: (authController) {

        return GetBuilder<ProfileController>(builder: (profileController) {
          return RefreshIndicator(
            onRefresh: () async {
              await loadData();
            },
            child: SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [

                  //Appbar
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _CustomSliverAppBarDelegate(
                        // maxHeight: 245,
                        maxHeight: 200,
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                                alignment: Alignment.center,
                                // height: 225,
                                height: 150,
                                color: Theme.of(context).textTheme.bodyLarge.color,
                                child: Column(
                                  children: [
                                    // SizedBox(height: 50),
                                    SizedBox(height: 40),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text(
                                                '${'welcome'.tr},',
                                                style: robotoBold.copyWith(
                                                  color: Theme.of(context).cardColor,
                                                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),

                                              authController.profileModel != null ?  Text(
                                                '${authController.profileModel.fName} ${authController.profileModel.lName}',
                                                style: robotoBold.copyWith(
                                                  color: Theme.of(context).cardColor,
                                                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ) : SizedBox.shrink(),
                                            ],
                                          ),
                                        ),

                                        InkWell(
                                          onTap: () {
                                            Get.find<LaundryNotificationController>().clearNotification();
                                            Get.find<LaundryNotificationController>().getNotificationList(1);
                                            Get.toNamed(RouteHelper.getLaundryNotificationRoute());
                                          },
                                          child: GetBuilder<LaundryNotificationController>(builder: (notificationController) {
                                            bool _hasNewNotification = false;
                                            if(notificationController.paginationLaundryNotificationModel?.data != null) {

                                              _hasNewNotification = notificationController.paginationLaundryNotificationModel?.data.length
                                                  != notificationController.getSeenNotificationCount();
                                            }
                                            return Container(
                                              alignment: Alignment.center,
                                              height: 44,
                                              width: 44,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Theme.of(context).hintColor.withOpacity(.4),
                                                  )
                                              ),
                                              child: Stack(
                                                children: [

                                                  Image.asset(
                                                    Images.notification,
                                                    height: 24,
                                                    width: 24,
                                                    color: Theme.of(context).cardColor,
                                                  ),

                                                  _hasNewNotification ? Positioned(
                                                    top: 2,
                                                    right: 2,
                                                    child: Container(
                                                      height: 8,
                                                      width: 8,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Theme.of(context).primaryColor
                                                      ),
                                                    ),
                                                  ) : SizedBox(),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                                    //   alignment: Alignment.center,
                                    //   decoration: BoxDecoration(
                                    //       color: Theme.of(context).cardColor,
                                    //       borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT)
                                    //   ),
                                    //   child: 
                                    //   // Row(
                                    //   //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //   //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   //   children: [

                                    //   //     // AppbarTitle(
                                    //   //     //   onTap: () {
                                    //   //     //     orderController.setSelectedOrderIndex(1);
                                    //   //     //     orderController.setFilterValue(AppConstants.pickedUp);
                                    //   //     //     Get.toNamed(RouteHelper.getOrderRoute(fromNav: false));
                                    //   //     //     Get.find<OrderController>().getOrderHistory(AppConstants.pickedUp, 1);
                                    //   //     //   },
                                    //   //     //   title: 'collected',
                                    //   //     //   count: profileController.deliveryManProfileModel != null ? '${profileController.deliveryManProfileModel.collectedOrdersCount}' : '0',
                                    //   //     // ),
                                        
                                        
                                    //   //     CustomDottedLine(),

                                    //   //     // AppbarTitle(
                                    //   //     //   onTap: () {
                                    //   //     //     orderController.setSelectedOrderIndex(1);
                                    //   //     //     orderController.setFilterValue(AppConstants.delivered);
                                    //   //     //     Get.toNamed(RouteHelper.getOrderRoute(fromNav: false));
                                    //   //     //     Get.find<OrderController>().getOrderHistory(AppConstants.delivered, 1);
                                    //   //     //   },
                                    //   //     //   title: 'delivered',
                                    //   //     //   count: profileController.deliveryManProfileModel != null ? '${profileController.deliveryManProfileModel.deliveredOrdersCount}' : '0',
                                    //   //     // ),

                                    //   //     CustomDottedLine(),
                                    //   //     // AppbarTitle(
                                    //   //     //   onTap: () {
                                    //   //     //     orderController.setSelectedOrderIndex(0);
                                    //   //     //     Get.toNamed(RouteHelper.getOrderRoute(fromNav: false));
                                    //   //     //   },
                                    //   //     //   title: 'inprogress',
                                    //   //     //   count: profileController.deliveryManProfileModel != null ? '${profileController.deliveryManProfileModel.beforeDeliveredOrdersCount + profileController.deliveryManProfileModel.beforePickedOrdersCount}' : '0',
                                    //   //     // ),
                                        
                                        
                                    //   //   ],
                                    //   // ),
                                    // ),
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  ),

                  //track order
                  // (orderController.outForPickup != null || orderController.outForDelivery != null ) ? (orderController.outForPickup.length > 1 || orderController.outForDelivery.length > 1 ) ? SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  //     child: OutlinedButton(onPressed: () => Get.toNamed(RouteHelper.getTrackPathRoute()), child: Text('track_path'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).primaryColor))),
                  //   ),
                  // ) : SliverToBoxAdapter(child: SizedBox(),) : SliverToBoxAdapter(child: SizedBox(),),

                  //TabBar
                  SliverPersistentHeader(
                    pinned: true,
                    floating: false,
                    delegate: _CustomSliverAppBarDelegate(
                      maxHeight: 50,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                        decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CustomTabBar(
                              title: 'pickups',
                              count: (orderController.pickUpOrderList != null && orderController.pickUpOrderList.length > 0) ? '${orderController.pickUpOrderList.length}' : '0',
                              isSelected: profileController.isSelected,
                              onTap: () {

                                orderController.setTabIndex(0);
                                profileController.setSelectedValue(true);
                                // orderController.getOrderList(AppConstants.OUT_FOR_PICKUP);
                              },
                            ),
                            CustomTabBar(
                              title: 'delivery',
                              count: (orderController.deliveryOrderList != null && orderController.deliveryOrderList.length > 0 ) ? '${orderController.deliveryOrderList.length}' : '0',
                              isSelected: !profileController.isSelected,
                              onTap: () {
                                orderController.setTabIndex(1);
                                profileController.setSelectedValue(false);
                                // orderController.getOrderList(AppConstants.OUT_FOR_DELIVERY);
                                orderController.setOrderPickedValue(false);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL)),

                  _orderList != null ? _orderList.length > 0 ? SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {

                      return PaginatedListView(
                        scrollController: _scrollController,
                        onPaginate: (int offset) async {
                          await orderController.getOrderList(offset);
                        },
                        totalSize: orderController.paginationOrderListModel.totalSize,
                        offset: orderController.paginationOrderListModel.offset != null ? int.parse(orderController.paginationOrderListModel.offset) : null,
                        productView: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          title: OrderItemView(
                            orderList: _orderList[index],
                            onTap: () async {
                              Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(_orderList[index]));
                            },
                          ),
                        ),
                      );
                    },
                      childCount: _orderList.length,
                    ),

                  ) : SliverToBoxAdapter(
                    child: NoDataScreen(text: 'no_order_found'.tr,),
                  ) : SliverToBoxAdapter(child: OrderShimmer(isEnabled: true,))
                ],
              ),
            ),
          );
        });
      });
    });
  }
}

class _CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final Widget child;

  _CustomSliverAppBarDelegate({
    @required this.maxHeight,
    @required this.child,
  });

  @override
  double get minExtent => maxHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_CustomSliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || child != oldDelegate.child;
  }
}

