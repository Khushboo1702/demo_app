import 'dart:convert';

import 'package:http/http.dart' as http;

class Data {
  final int userId;
  late final int id;
  final String title;
  final int? quantity;

  Data({
    required this.userId,
    required this.id,
    required this.title,
    required this.quantity,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      quantity: json['quantity'],
    );
  }

  Map<String, Object?> toMap() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'quantity': quantity,
    };
  }
}
