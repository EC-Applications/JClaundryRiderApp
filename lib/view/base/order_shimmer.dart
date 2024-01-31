import 'package:dotted_line/dotted_line.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class OrderShimmer extends StatelessWidget {
  final bool isEnabled;
  OrderShimmer({@required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index)  {
        return Container(
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], blurRadius: 5, spreadRadius: 1)],
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: isEnabled,
            child: Column(children: [

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                    border: Border.all(color: Theme.of(context).disabledColor.withOpacity(.5))
                ),
                child: Column(
                  children: [

                    Row(
                      children: [

                        Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

                        Expanded(
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 15,
                                      width: MediaQuery.of(context).size.width * .4,
                                      color: Theme.of(context).disabledColor.withOpacity(.2),
                                    )
                                  ),
                                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE * 4,),

                                  Container(
                                    height: 15,
                                    width: 50,
                                    color: Theme.of(context).disabledColor.withOpacity(.2),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL,),
                              Row(

                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).disabledColor.withOpacity(.2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 15,
                                            width: MediaQuery.of(context).size.width * .4,
                                            color: Theme.of(context).disabledColor.withOpacity(.2),
                                          ),
                                        ),


                                        Flexible(
                                          child: Container(
                                            height: 15,
                                            width: 50,
                                            color: Theme.of(context).disabledColor.withOpacity(.2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                    DottedLine(
                      direction: Axis.horizontal,
                      dashColor: Theme.of(context).disabledColor.withOpacity(.4),
                      dashGapLength: 2,
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).disabledColor.withOpacity(.2),
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT,),

                        Container(
                          height: 15,
                          width: MediaQuery.of(context).size.width * .4,
                          color: Theme.of(context).disabledColor.withOpacity(.2),
                        ),

                        Spacer(),


                        Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).disabledColor.withOpacity(.2),
                            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          ),

                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ]),
          ),
        );
      }
    );
  }
}
