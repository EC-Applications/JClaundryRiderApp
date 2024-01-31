import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/view/base/no_data_screen.dart';
import 'package:efood_multivendor_driver/view/base/order_item_view.dart';
import 'package:efood_multivendor_driver/view/base/order_shimmer.dart';
import 'package:efood_multivendor_driver/view/base/paginated_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderView extends StatelessWidget {
  final List<OrderList> orderList;
  final bool isHistory;
  final ScrollController scrollController;
  OrderView({@required this.orderList, this.isHistory = false, @required this.scrollController});


  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return orderList != null ?  orderList.length > 0 ?  PaginatedListView(
        scrollController: scrollController,
        totalSize: orderController.selectedOrderIndex == 0 ? orderController.paginationOrderListModel?.totalSize : orderController.paginationHistoryOrderListModel?.totalSize,
        offset: orderController.selectedOrderIndex == 0 ? orderController.paginationOrderListModel?.offset != null ? int.parse(orderController.paginationOrderListModel?.offset) : null :
        orderController.paginationHistoryOrderListModel?.offset != null ? int.parse(orderController.paginationHistoryOrderListModel?.offset) : null,
        onPaginate: (int offset) async{
          debugPrint('------>offset: $offset');
          if(orderController.selectedOrderIndex == 0) {
            await orderController.getOrderList(offset);
          }else {
            await orderController.getOrderHistory(orderController.filterValue, offset);
          }

        },
        productView: ListView.builder(
          shrinkWrap: true,
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          physics: BouncingScrollPhysics(),
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            return  Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
              child: OrderItemView(
                isHistory: isHistory,
                orderList: orderList[index],
                onTap: () async{
                  Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(orderList[index]));
                },

              ),
            );
          },
        ),
      ):
      NoDataScreen(text: 'no_order_found'.tr) :  OrderShimmer(isEnabled: true);
    });
  }
}
