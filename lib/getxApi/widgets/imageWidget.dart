import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterGet/getxApi/model/productModel.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key key,
    @required this.productData,
  }) : super(key: key);

  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: productData.imageLink,
      placeholder: (context, url) => Image.network(
          "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png"),
      errorWidget: (context, url, error) => Image.network(
          "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png"),
    );
  }
}
