import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/model/response/laundry_service_item_model.dart';
import '../../../../controller/laundry_cart_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import 'add_remove_widget.dart';


class ProductViewLaundry extends StatefulWidget {
  final int servicesId;
  final int laundryItemId;
  final String imgUrl;
  final String productName;
  final num actualPrice;
  final String discountedPrice;
  final bool isDiscounted;
  final bool isFromCart;
  final int percatage;
  final List<Addons> addons;

  ProductViewLaundry(
      {@required this.servicesId,
      @required this.laundryItemId,
      @required this.imgUrl,
      @required this.productName,
      @required this.actualPrice,
      @required this.discountedPrice,
      @required this.percatage,
      this.isDiscounted = false,
      this.isFromCart = false,
      this.addons});

  @override
  State<ProductViewLaundry> createState() => _ProductViewLaundryState();
}


class _ProductViewLaundryState extends State<ProductViewLaundry> {


  List<int> selectedOption= [];
  num calculatedPrice;
  List<Addons> selectedAddons = <Addons>[]; 


@override
void initState() {
  super.initState();
  calculatedPrice = widget.isDiscounted
      ? (widget.actualPrice - (widget.actualPrice * (widget.percatage / 100)))
      : widget.actualPrice;
}



  @override
  Widget build(BuildContext context) {
    final _scrollController = ScrollController();
    return GetBuilder<LaundryCartController>(builder: (cartController) {
      return Container(
        margin:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
        padding:
            EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withOpacity(.3),
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            children: [
              Row(
                children: [
                 Image.network(widget.imgUrl, height: 60, width: 60,),
              
                  SizedBox(
                    width: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName.tr,
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: Theme.of(context).textTheme.bodyLarge.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Column(
                          children: [
                            Text(
                              'RS ${widget.actualPrice}',
                              style: TextStyle(
                                color: widget.isDiscounted ? Colors.red : Colors.black,
                                decoration: widget.isDiscounted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                              // style: TextStyle(
                              //   color: Colors.black,
                              // ),
                            ),
                            if (widget.isDiscounted) SizedBox(width: 5),
                            if (widget.isDiscounted)
                              Text(
                                'RS $calculatedPrice',
                                style: TextStyle(
                                  color: Colors.green, // Adjust color as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.isDiscounted)
                    Text(
                      '%${widget.percatage}',
                      style: TextStyle(color: Colors.red),
                    ),


              AddRemoveWidget(imgUrl: Images.remove, onTap: () {
                cartController.setQuantity(widget.laundryItemId, widget.servicesId, false);

              },),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
              Text(cartController.getQuantity(widget.laundryItemId,widget.servicesId).toString(), style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: Theme.of(context).textTheme.bodyLarge.color),),
              SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),
              AddRemoveWidget(imgUrl: Images.add, onTap: () {

                if (cartController.getQuantity(widget.laundryItemId, widget.servicesId) == 0) {
                  cartController.addToCart(widget.servicesId, widget.laundryItemId, 1, widget.actualPrice, widget.productName);
                } else {
                  cartController.setQuantity(widget.laundryItemId, widget.servicesId, true);
                }


              },),



],
              ),
widget.addons != null && widget.addons.length > 0
  ? SizedBox(
      height: 30,
      child: Row(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: widget.addons.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final addon = widget.addons[index];
              return Wrap(
                children:[ 
                   Checkbox(
                  value: selectedOption.contains(addon.id), 
                  
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked) {
                        selectedOption.add(addon.id);
                        calculatedPrice = calculatedPrice + num.parse(addon.price);
                        selectedAddons.add(addon);
                         
                       } else {
                        selectedOption.remove(addon.id);
                        calculatedPrice = calculatedPrice - num.parse(addon.price);
                        selectedAddons.remove(addon);
                      }
                    });
                  },
                ),
                  
                Text("${addon.name} \n ${addon.price})")
                ]
              );
            },
          ),
        ],
      ),
    )
  : SizedBox()

            ],
          ),
        ));
    });
  }
}
