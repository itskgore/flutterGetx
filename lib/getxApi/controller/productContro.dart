import 'package:flutterGet/getxApi/model/productModel.dart';
import 'package:flutterGet/getxApi/services/api_services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

enum ProductStates { Loading, Loaded, Error }

class ProductController extends GetxController {
  List<ProductData> productList = List<ProductData>().obs;
  ApiServices _apiServices = ApiServices();

  // States
  var states = ProductStates.Loaded.obs;

  // Selected Index
  var index = 0.obs;

  var selectedColor = 0.obs;

  Future<void> getProducts() async {
    states(ProductStates.Loading);
    final data = await _apiServices
        .getMethod("https://makeup-api.herokuapp.com/api/v1/products.json");
    if (data['status']) {
      data['data'].forEach((key) {
        if (productList.length < 30) {
          productList.add(ProductData.fromJson(key));
        }
      });
      states(ProductStates.Loaded);

      print(productList.length);
    } else {
      states(ProductStates.Error);
    }
  }

  void markAsFav(int index) {
    productList[index].isFav = !productList[index].isFav;
    update(['selectedColor']);
  }

  changeSelectedColor(dynamic i) {
    selectedColor(i);
    update(['selectedColor']);
  }

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }
}
