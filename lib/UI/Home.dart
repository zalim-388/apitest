import 'package:apitest/bloc/imdb_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ImdbBloc>(context).add(fetchTopMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMDB Top 100 Movies'),
      ),
      body: BlocBuilder<ImdbBloc, ImdbState>(
        builder: (context, state) {
          if (state is ImdbblocLoading) {
            print('Loading');
            return Center(child: CircularProgressIndicator());
          } else if (state is ImdbblocError) {
            return Center(child: Text('Something went wrong!'));
          } else if (state is ImdbblocLoadied) {
            var data = BlocProvider.of<ImdbBloc>(context).imdbmodel;

            return ListView.builder(
              itemCount: data.genre!.length,
              itemBuilder: (context, index) {
                // final movie = state.movies[index];

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(
                      data.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.movie),
                    ),
                    title: Text(data.id.toString()),
                    subtitle:
                        Text('Rating: ${[data.rank]} | Year: ${data.year}'),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
