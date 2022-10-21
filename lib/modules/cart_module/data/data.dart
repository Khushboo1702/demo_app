import 'dart:convert';

import 'package:http/http.dart' as http;

class Data {
  final int userId;
  final int id;
  final String title;
  final int? quantity;
  //final int uniqueId;

  Data({
    required this.userId,
    required this.id,
    required this.title,
    required this.quantity,
    //required this.uniqueId\
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
      //  uniqueId: uniqueId ?? json['uniqueId']
    );
  }

  Map<String, Object?> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'quantity': quantity,
      //'uniqueId': uniqueId,
    };
  }
}

//(TODO): Don't declare global function
Future<List<Data>> fetchData() async {
  //int uniqueId = 0;

  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) {
      return Data.fromJson(data);
    }).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
