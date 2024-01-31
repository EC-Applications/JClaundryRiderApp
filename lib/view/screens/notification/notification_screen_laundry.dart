
import 'package:efood_multivendor_driver/controller/laundry_notification_controller.dart';
import 'package:efood_multivendor_driver/data/model/response/order_list_model.dart';
import 'package:efood_multivendor_driver/helper/route_helper.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/laundry_custom_appbar.dart';
import 'package:efood_multivendor_driver/view/base/laundry_title_widget.dart';
import 'package:efood_multivendor_driver/view/base/paginated_list_view.dart';
import 'package:efood_multivendor_driver/view/screens/notification/widget/order_status_icon_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreenLaundry extends StatefulWidget {

  @override
  State<NotificationScreenLaundry> createState() => _NotificationScreenLaundryState();
}

class _NotificationScreenLaundryState extends State<NotificationScreenLaundry> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Get.find<LaundryNotificationController>().getNotificationList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: LaundryCustomAppbar(
        title: 'notifications',
        leadingImgUrl: Images.remove_laundry,
        imgHeight: 16,
        imgWidth: 16,
      ),
      body: GetBuilder<LaundryNotificationController>(builder: (notificationController) {
        if(notificationController.paginationLaundryNotificationModel?.data != null) {
          notificationController.saveSeenNotificationCount(notificationController.paginationLaundryNotificationModel?.data?.length);
        }
        return notificationController.paginationLaundryNotificationModel?.data != null ?
        notificationController.paginationLaundryNotificationModel?.data?.length > 0 ? PaginatedListView(
          scrollController: scrollController,
          onPaginate: (int offset) async {
            debugPrint('------>offset: $offset');
            await notificationController.getNotificationList(offset);
          },
          totalSize: notificationController.paginationLaundryNotificationModel?.totalSize,
          offset: notificationController.paginationLaundryNotificationModel?.offset != null ? int.parse(notificationController.paginationLaundryNotificationModel?.offset) : null,
          productView:  Column(
            children: [
              Divider(),

              ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: notificationController.paginationLaundryNotificationModel?.data.length,
                itemBuilder: (context, index) {
                  final notification = notificationController.paginationLaundryNotificationModel?.data.toList()[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getOrderPickupDetailsRoute(OrderList(id: notification.orderId)));
                    },
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderStatusIconView(
                                imgUrl: Images.confirmed_icon,
                                color: Color(0xFFE9FFF2),
                              ),
                              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LaundryTitleWidget(
                                      titleName: '${notification.value}',
                                      fontSize: Dimensions.FONT_SIZE_SMALL,
                                    ),
                                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                                    Text(
                                      '${'order_id'.tr}: ${notification.orderId}',
                                      style: robotoRegular.copyWith(
                                        color: Theme.of(context).textTheme.bodyLarge.color.withOpacity(.8),
                                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                                child: Text(
                                  '${notification.time}',
                                  style: robotoRegular.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge.color.withOpacity(.8),
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                        Divider()
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ) : Center(
            child: Text(
              'no_notification_found'.tr,
              style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
            )
        ) : Center(child: CircularProgressIndicator(),);

      }),
    ) ;
  }
}
