import 'dart:convert';

import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<List<Data>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) {
        return Data.fromJson(data);
      }).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
