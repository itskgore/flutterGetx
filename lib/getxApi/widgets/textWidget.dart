import 'package:flutter/material.dart';
import 'package:flutterGet/getxApi/model/productModel.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key key,
    @required this.style,
    @required this.productData,
  }) : super(key: key);

  final ProductData productData;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      productData.description,
      textAlign: TextAlign.justify,
      softWrap: true,
      style: style,
    );
  }
}
