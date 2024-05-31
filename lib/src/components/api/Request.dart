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
    try {
      final response = await http.get(Uri.parse('$baseURL$endpoint'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if(snapshot.hasError){
          return Text("Error: ${snapshot.error}");
        } else if(!snapshot.hasData) {
          return const Text("No data found");
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}


class Promise extends StatelessWidget {
  final List<String> endpoints;
  final Widget Function(BuildContext context, List<dynamic> data) builder;

  const Promise({
    Key? key,
    required this.endpoints,
    required this.builder,
  }) : super(key: key);

  Future<List<dynamic>> fetchData() async {
    try {
      List<http.Response> responses = await Future.wait(
        endpoints.map((endpoint) => http.get(Uri.parse('$baseURL$endpoint'))),
      );

      List<dynamic> data = responses.map((response) {
        if (response.statusCode == 200) {
          return json.decode(response.body);
        } else {
          throw Exception('Failed to load data from ${response.request?.url}');
        }
      }).toList();

      return data;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return builder(context, snapshot.data as List<dynamic>);
        }
      },
    );
  }
}


class FutureRequest extends StatelessWidget {
  final String endpoint;
  final AsyncWidgetBuilder<dynamic> builder;

  const FutureRequest({
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
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}