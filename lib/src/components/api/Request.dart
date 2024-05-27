import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:e_pod/src/config.dart';

class Request extends StatelessWidget {
  final String endpoint;
  final Widget Function(BuildContext context, AsyncSnapshot snapshot) builder;


  const Request({
    Key? key,
    required this.endpoint,
    required this.builder,
  }) : super(key: key);

  Future<dynamic> fetchData() async {
    final response = await http.get(Uri.parse('$baseURL$endpoint'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: builder,
    );
  }
}
