import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  Future fetchPost(page) async {
    final response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=10"));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      debugPrint(response.statusCode.toString());
      return response.statusCode;
    }
  }
}
