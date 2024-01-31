import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/paginated_list_view.dart';
import 'package:efood_multivendor_driver/view/screens/home/widget/custom_tab_bar.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/order_filter_widget.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/order_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  final bool fromNav;
  OrderScreen({this.fromNav = false});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ScrollController _scrollController = ScrollController();
  
  ongoingDataLoad() async {
    await Get.find<OrderController>().getOrderList(1);
  }
  
  @override
  void initState() {
    ongoingDataLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<OrderController>(builder: (orderController) {
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: CustomAppBar(title: widget.fromNav ? 'my_orders'.tr : 'orders'.tr, isBackButtonExist: !widget.fromNav,),
        body: Column(
          children: [

            Container(
              height: 50,
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
                    isCountVisible: false,
                    title: 'ongoing'.tr,
                    isSelected: orderController.selectedOrderIndex == 0,
                    onTap: () {
                      orderController.setSelectedOrderIndex(0);
                    },
                  ),

                  CustomTabBar(
                    isCountVisible: false,
                    title: 'history'.tr,
                    isSelected: orderController.selectedOrderIndex == 1,
                    onTap: () {
                      orderController.setSelectedOrderIndex(1);
                      orderController.getOrderHistory('all', 1);
                      orderController.setFilterValue('all');
                    },
                  ),

                ],
              ),
            ),
            // SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),

            /// Ongoing Orders
            if(orderController.selectedOrderIndex == 0) DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(

                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: 3,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      labelStyle: robotoMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
                      onTap: (index) {
                        if(index == 0) {
                          orderController.getOrderList(1);
                        }
                        if(index == 1) {
                          orderController.getOrderList(1);
                        }
                        if(index == 2) {
                          orderController.getOrderList(1);
                        }
                      },
                      tabs: [
                        Tab(text: 'pickup'.tr,),
                        Tab(text: 'delivery'.tr),
                        Tab(text: 'collected'.tr),

                      ],
                    ),

                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE,),

                    Expanded(
                      child: TabBarView(children: [
                        OrderView(orderList: orderController.myOrdersPickUpList, scrollController: _scrollController,),
                        OrderView(orderList: orderController.deliveryOrderList, scrollController: _scrollController,),
                        OrderView(orderList: orderController.pickedOrderList, scrollController: _scrollController,),

                      ]),
                    ),
                  ],
                ),
              ),
            ),
            if(orderController.selectedOrderIndex == 0) SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

            /// History Orders
            if(orderController.selectedOrderIndex == 1) Align(alignment: Alignment.centerRight,
              child: OrderFilterWidget(
                onSelected: (String value) {
                  orderController.setFilterValue(value);
                  orderController.getOrderHistory(value, 1);
                },
              ),
            ),

            if(orderController.selectedOrderIndex == 1) Expanded(child: OrderView(orderList: orderController.orderHistory, isHistory: true, scrollController: _scrollController,)),



          ],
        ),
      );
    });
  }

}



