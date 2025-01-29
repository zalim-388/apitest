import 'package:apitest/main.dart';
import 'package:flutter/material.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late Future<List<dynamic>> _moviesList;

  @override
  void initState() {
    super.initState();
    _moviesList = ApiService().fetchTopMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMDB Top 100 Movies'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _moviesList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies available'));
          }

          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Image.network(
                    movie['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.movie),
                  ),
                  title: Text(movie['title']),
                  subtitle: Text(
                      'Rating: ${movie['rating']} | Year: ${movie['year']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}