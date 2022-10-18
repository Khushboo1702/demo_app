import 'dart:convert';

import 'package:http/http.dart' as http;

class Data {
  final int userId;
  final int id;
  final String title;
  //final int uniqueId = 0;

  Data({required this.userId, required this.id, required this.title});

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(userId: json['userId'], id: json['id'], title: json['title']);
  }

  Map<String, Object?> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      // 'uniqueId': uniqueId,
    };
  }
}

Future<List<Data>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
