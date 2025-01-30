
import 'package:apitest/UI/Home.dart';
import 'package:apitest/bloc/imdb_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

