
import 'package:efood_multivendor_driver/controller/laundry_cart_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/images.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/screens/order/widget/add_remove_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductViewLaundry extends StatelessWidget {
  final int servicesId;
  final int laundryItemId;
  final String imgUrl;
  final String productName;
  final String productPrice;


  ProductViewLaundry({@required this.servicesId, @required this.laundryItemId, @required this.imgUrl, @required this.productName, @required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaundryCartController>(builder: (cartController) {

      return Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Theme.of(context).disabledColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 0.5, blurStyle: BlurStyle.outer, ),
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Row(
            children: [
              Image.network(imgUrl, height: 60, width: 60,),
              SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE,),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName.tr,
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        color: Theme.of(context).textTheme.bodyLarge.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      productPrice,
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        color: Theme.of(context).textTheme.bodyLarge.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),




              AddRemoveWidget(imgUrl: Images.remove, onTap: () {
                cartController.setQuantity(laundryItemId, servicesId, false);

              },),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
              Text(cartController.getQuantity(laundryItemId,servicesId).toString(), style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
              AddRemoveWidget(imgUrl: Images.add, onTap: () {

                if (cartController.getQuantity(laundryItemId, servicesId) == 0) {
                  cartController.addToCart(servicesId, laundryItemId, 1, double.parse(productPrice), productName);
                } else {
                  cartController.setQuantity(laundryItemId, servicesId, true);
                }


              },),



            ],
          ),
        ),
      );
    });
  }
}
