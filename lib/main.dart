import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CastListScreen(),
    );
  }
}

class CastListScreen extends StatefulWidget {
  @override
  _CastListScreenState createState() => _CastListScreenState();
}

class _CastListScreenState extends State<CastListScreen> {
  late Future<List<dynamic>> _castList;

  @override
  void initState() {
    super.initState();
    _castList = ApiService().fetchCast();
  }

  void _remove(int index) {
    setState(() {
      _castList.then((cast) {
        cast.removeAt(index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMDB Cast List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _castList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cast data available'));
          }

          final cast = snapshot.data!;
          return ListView.builder(
            itemCount: cast.length,
            itemBuilder: (context, index) {
              final actor = cast[index];
              final characters =
                  (actor['characters'] as List<dynamic>).join(', ');
              return GestureDetector(
                onLongPress: () => _remove(index),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(actor['fullName'][0]), // Placeholder for images
                  ),
                  title: Text(actor['fullName']),
                  subtitle:
                      Text('Job: ${actor['id']}\nCharacters: $characters'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ApiService {
  static const String _baseUrl =
      'https://imdb236.p.rapidapi.com/imdb/tt7631058/cast';
  static const Map<String, String> _headers = {
    'x-rapidapi-host': 'imdb236.p.rapidapi.com',
    'x-rapidapi-key': 'ca62211e4cmshcd22b3f6295b989p18b2ccjsn35cbabc6e276',
  };

  Future<List<dynamic>> fetchCast() async {
    final response = await http.get(Uri.parse(_baseUrl), headers: _headers);

    if (response.statusCode == 200) {
      // Decode the JSON array directly as a list
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
