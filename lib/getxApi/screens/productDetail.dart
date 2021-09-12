import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterGet/getxApi/controller/productContro.dart';
import 'package:flutterGet/getxApi/model/productModel.dart';
import 'package:flutterGet/getxApi/widgets/imageWidget.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }),
      ),
      bottomSheet: Container(
        height: media.height * 0.08,
        width: double.infinity,
        child: OutlinedButton(
          child: Text('Buy Now!'),
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.teal,
            shadowColor: Colors.teal,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          onPressed: () {
            print('Pressed');
          },
        ),
      ),
      body: GetBuilder<ProductController>(
          id: 'selectedColor',
          init: ProductController(),
          builder: (product) {
            final productData =
                product.productList[int.parse(product.index.toString())];

            return SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: productData.id,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.black,
                              Colors.transparent
                            ],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Container(
                          width: double.infinity,
                          height: media.height * 0.30,
                          child: ImageWidget(productData: productData),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.height * 0.03,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Category : " +
                                    productData.category.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 15),
                              ),
                              Spacer(),
                              IconButton(
                                  icon: Icon(Icons.share),
                                  onPressed: () {
                                    Get.snackbar(
                                      "Hello there!",
                                      "This is a getx snackbar",
                                      icon: Icon(Icons.person,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }),
                              IconButton(
                                  color: productData.isFav
                                      ? Colors.teal
                                      : Colors.black,
                                  icon: Icon(productData.isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  onPressed: () {
                                    product.markAsFav(product.index.toInt());
                                  }),
                              IconButton(
                                  icon: Icon(Icons.shopping_bag_outlined),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Hey Hi!",
                                      middleText:
                                          "This is a defualy dialog box from getx",
                                      backgroundColor: Colors.teal,
                                      titleStyle:
                                          TextStyle(color: Colors.white),
                                      middleTextStyle:
                                          TextStyle(color: Colors.white),
                                    );
                                  }),
                            ],
                          ),
                          buildSizedBox(media, 0.02),
                          Text(
                            productData.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          Divider(),
                          Text(
                            productData.description,
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                height: 1.5,
                                wordSpacing: 2),
                          ),
                          buildSizedBox(media, 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: media.height * 0.10,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: productData.productColors.length,
                                    itemBuilder: (con, i) {
                                      String color = productData
                                          .productColors[i].hexValue
                                          .replaceAll('#', '0xff');

                                      return GestureDetector(
                                        onTap: () {
                                          product.changeSelectedColor(i);
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 400),
                                          width: 30,
                                          height: 30,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      product.selectedColor == i
                                                          ? Colors.teal
                                                          : Colors.transparent,
                                                  width:
                                                      product.selectedColor == i
                                                          ? 3
                                                          : 0),
                                              shape: BoxShape.circle,
                                              color: Color(int.parse(color))),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          buildSizedBox(media, 0.01),
                          Container(
                            width: double.infinity,
                            height: media.height * 0.05,
                            child: OutlinedButton(
                              child: Expanded(
                                child: Text(
                                  '${productData.productLink}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Colors.teal[700],
                                shadowColor: Colors.teal,
                                elevation: 10,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          buildSizedBox(media, 0.02),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  SizedBox buildSizedBox(Size media, double height) {
    return SizedBox(
      height: media.height * height,
    );
  }
}
