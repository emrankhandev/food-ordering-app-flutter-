import 'package:flutter/material.dart';
import 'package:food_order_app/controller/cart_controller.dart';
import 'package:food_order_app/controller/popular_product_controller.dart';
import 'package:food_order_app/controller/recommended_product_controller.dart';
import 'package:food_order_app/pages/home/main_food_page.dart';
import 'package:food_order_app/routes/route_helper.dart';
import 'package:food_order_app/utils/app_constants.dart';
import 'package:food_order_app/utils/colors.dart';
import 'package:food_order_app/utils/dimenssions.dart';
import 'package:food_order_app/widgets/app_icon.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:food_order_app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimenssions.width20,
              top: Dimenssions.height20 * 3,
              right: Dimenssions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimenssions.iconSize24,
                  ),
                  SizedBox(
                    width: Dimenssions.width20 * 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimenssions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimenssions.iconSize24,
                  ),
                ],
              )),
          Positioned(
            top: Dimenssions.height20 * 5,
            left: Dimenssions.width20,
            right: Dimenssions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimenssions.height15),
              //color: Colors.red,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController) {
                  var _cartList = cartController.getItems;
                  return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: Dimenssions.height20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, "cartpage"));
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                    Get.toNamed(RouteHelper.getRecommendedFood(
                                        recommendedIndex, "cartpage"));
                                  }
                                },
                                child: Container(
                                  width: Dimenssions.height20 * 5,
                                  height: Dimenssions.height20 * 5,
                                  margin: EdgeInsets.only(
                                    bottom: Dimenssions.height10,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              cartController
                                                  .getItems[index].img!,
                                        )),
                                    borderRadius: BorderRadius.circular(
                                        Dimenssions.radius20),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimenssions.width10,
                              ),
                              Expanded(
                                  child: Container(
                                height: Dimenssions.height20 * 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    BigText(
                                      text:
                                          cartController.getItems[index].name!,
                                      color: Colors.black54,
                                    ),
                                    SmallText(text: "Spicy"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: "\$ " +
                                              cartController
                                                  .getItems[index].price
                                                  .toString(),
                                          color: Colors.redAccent,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: Dimenssions.height10,
                                            bottom: Dimenssions.height10,
                                            left: Dimenssions.width10,
                                            right: Dimenssions.width10,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimenssions.radius20),
                                              color: Colors.white),
                                          child: Row(
                                            children: [
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     cartController.addItem(
                                              //         _cartList[index].product!,
                                              //         -1);
                                              //   },
                                              //   child: Icon(
                                              //     Icons.remove,
                                              //     color: AppColors.mainColor,
                                              //   ),
                                              // ),
                                              SizedBox(
                                                width: Dimenssions.width10 / 2,
                                              ),
                                              BigText(
                                                  text: _cartList[index]
                                                      .quantity
                                                      .toString()),
                                              //popularProduct.inCartItems.toString()),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     cartController.addItem(
                                              //         _cartList[index].product!,
                                              //         1);
                                              //    // print("tapped");
                                              //   },
                                              //   child: Icon(
                                              //     Icons.add,
                                              //     color: AppColors.mainColor,
                                              //   ),
                                              // ),
                                              SizedBox(
                                                width: Dimenssions.width10 / 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      });
                }),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartControler) {
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
                      SizedBox(
                        width: Dimenssions.width10 / 2,
                      ),
                      BigText(
                          text: "\$ " + cartControler.totalAmount.toString()),
                      SizedBox(
                        width: Dimenssions.width10 / 2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    cartControler.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimenssions.height20,
                        bottom: Dimenssions.height20,
                        left: Dimenssions.width20,
                        right: Dimenssions.width20),
                    child: BigText(
                      text: "Check out",
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
