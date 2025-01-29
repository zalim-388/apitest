import 'dart:convert';

import 'package:apitest/UI/Home.dart';
import 'package:apitest/bloc/imdb_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ImdbBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MoviesScreen(),
        ));
  }
}

class ApiService {
  static const String _baseUrl = 'https://imdb-top-100-movies.p.rapidapi.com/';
  static const Map<String, String> _headers = {
    'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com',
    'x-rapidapi-key': 'ca62211e4cmshcd22b3f6295b989p18b2ccjsn35cbabc6e276',
  };

  Future<List<dynamic>> fetchTopMovies() async {
    final response = await http.get(Uri.parse(_baseUrl), headers: _headers);

    if (response.statusCode == 200) {
      return json.decode(response.body); // API returns a list directly
    } else {
      throw Exception('Failed to load data');
    }
  }
}
