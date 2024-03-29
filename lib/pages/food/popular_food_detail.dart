import 'package:flutter/material.dart';
import 'package:food_order_app/controller/cart_controller.dart';
import 'package:food_order_app/controller/popular_product_controller.dart';
import 'package:food_order_app/pages/cart/cart_page.dart';
import 'package:food_order_app/pages/home/main_food_page.dart';
import 'package:food_order_app/routes/route_helper.dart';
import 'package:food_order_app/utils/app_constants.dart';
import 'package:food_order_app/utils/colors.dart';
import 'package:food_order_app/utils/dimenssions.dart';
import 'package:food_order_app/widgets/app_column.dart';
import 'package:food_order_app/widgets/app_icon.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:food_order_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimenssions.popularFoodImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          product.img!))),
            ),
          ),
          Positioned(
              top: Dimenssions.height40,
              left: Dimenssions.width20,
              right: Dimenssions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        }else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 4,
                                  top: 4,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimenssions.popularFoodImgSize,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimenssions.width20,
                    right: Dimenssions.width20,
                    top: Dimenssions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimenssions.radius20),
                    topLeft: Radius.circular(Dimenssions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimenssions.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimenssions.height20,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                                  text: product.description!))),
                    ]),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimenssions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimenssions.height30,
                bottom: Dimenssions.height30,
                left: Dimenssions.width20,
                right: Dimenssions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimenssions.radius20 * 2),
                  topRight: Radius.circular(Dimenssions.radius20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimenssions.height20,
                    bottom: Dimenssions.height20,
                    left: Dimenssions.width20,
                    right: Dimenssions.width20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimenssions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimenssions.width10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.mainColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimenssions.width10 / 2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimenssions.height20,
                        bottom: Dimenssions.height20,
                        left: Dimenssions.width20,
                        right: Dimenssions.width20),
                    child: BigText(
                      text: "\$${product.price!} | Add to cart",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimenssions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
