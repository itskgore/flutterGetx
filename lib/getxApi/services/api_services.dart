import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  static var client = http.Client();

  Future<Map<String, dynamic>> getMethod(String url) async {
    try {
      final response = await http.get(url);
      return getResponse(response);
    } catch (e) {
      return {"status": false, "msg": "Something went wrong"};
    }
  }

  Map<String, dynamic> getResponse(http.Response response) {
    if (response.statusCode == 200) {
      return {
        "status": true,
        "data": json.decode(response.body),
        "msg": "Data fetched"
      };
    } else {
      return {"status": false, "msg": "Something went wrong"};
    }
  }
}
