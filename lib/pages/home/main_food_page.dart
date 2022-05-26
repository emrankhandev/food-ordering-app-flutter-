import 'package:flutter/material.dart';
import 'package:food_order_app/pages/home/food_page_body.dart';
import 'package:food_order_app/utils/colors.dart';
import 'package:food_order_app/utils/dimenssions.dart';
import 'package:food_order_app/widgets/big_text.dart';
import 'package:food_order_app/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimenssions.height45, bottom: Dimenssions.height15),
            padding: EdgeInsets.only(
                left: Dimenssions.width20, right: Dimenssions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: "Bangladesh",
                      color: AppColors.greenColor,
                      //size: 20,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: "Rangpur",
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Container(
                  width: Dimenssions.width40,
                  height: Dimenssions.height40,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: Dimenssions.iconSize24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimenssions.radius15),
                    color: AppColors.greenColor,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: FoodPageBody(),
        )),
      ]),
    );
  }
}
