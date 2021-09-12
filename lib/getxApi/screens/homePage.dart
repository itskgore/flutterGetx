import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterGet/getxApi/controller/productContro.dart';
import 'package:flutterGet/getxApi/screens/productDetail.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Shop with GetX',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 32,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.view_list_rounded), onPressed: () {}),
                IconButton(icon: Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
              child: Obx(
            () => productController.states == ProductStates.Loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : productController.states == ProductStates.Error
                    ? Center(
                        child: Text("Error"),
                      )
                    : ListView.builder(
                        itemCount: productController.productList.length,
                        itemBuilder: (con, index) {
                          final product = productController.productList[index];
                          return GestureDetector(
                            onTap: () {
                              productController.index(index);
                              productController.selectedColor(0);
                              Get.to(ProductDetails());
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
                              height: media.height * 0.13,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: media.width * 0.25,
                                    height: double.infinity,
                                    child: Card(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Hero(
                                          tag: product.name,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: product.imageLink,
                                            placeholder: (context, url) =>
                                                Image.network(
                                                    "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png"),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.network(
                                                    "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                product.description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                "${product.priceSign} "
                                                "${product.price}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: double.infinity,
                                                width: media.width * 0.10,
                                                child: Expanded(
                                                  child: ListView.builder(
                                                    itemCount: product
                                                        .productColors.length,
                                                    itemBuilder: (con, i) {
                                                      String color = product
                                                          .productColors[i]
                                                          .hexValue
                                                          .replaceAll(
                                                              '#', '0xff');

                                                      return Container(
                                                        width: 10,
                                                        height: 10,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    int.parse(
                                                                        color))),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        }),
          ))
          // Expanded(
          //   child: GetX<ProductController>(
          //       init:
          //           ProductController(), // If you don't wanna use Get.put(ProductController()); and save memory
          //       builder: (controller) =>
          //           controller.states == ProductStates.Loading
          //               ? Center(
          //                   child: CircularProgressIndicator(),
          //                 )
          //               : controller.states == ProductStates.Error
          //                   ? Center(
          //                       child: Text("Error"),
          //                     )
          //                   : ListView.builder(
          //                       itemCount: controller.productList.length,
          //                       itemBuilder: (con, index) {
          //                         return Container(
          //                           margin: EdgeInsets.only(
          //                               top: 10, left: 10, right: 10),
          //                           height: MediaQuery.of(context).size.height *
          //                               0.10,
          //                           width: double.infinity,
          //                           decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(5),
          //                               color: Colors.grey),
          //                         );
          //                       },
          //                     )),
          // )
        ],
      ),
    );
  }
}
