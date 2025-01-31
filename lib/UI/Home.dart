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
      body: BlocBuilder<ImdbBloc, ImdbState>(builder: (context, state) {
        if (state is ImdbblocLoading) {
          print('Loading');
          return Center(child: CircularProgressIndicator());
        } else if (state is ImdbblocError) {
          return Center(child: Text('Something went wrong!'));
        } else if (state is ImdbblocLoadied) {
          var data = BlocProvider.of<ImdbBloc>(context).imdbMovies;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(data.elementAt(index).title.toString()),
                  leading:Image.network(
                    data.elementAt(index).image.toString(),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  //  Text(
                  //   data.elementAt(index).rank.toString(),
                  // ),
                  subtitle: Text('imdb id: ${[
                    data.elementAt(index).title.toString(),
                  ]} | Link: ${[
                    data.elementAt(index).description.toString(),
                  ]}'),
                ),
              );
            },
          );
        }
        return Container();
      }),
    );
  }
}
