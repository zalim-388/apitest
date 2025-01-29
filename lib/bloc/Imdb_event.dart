part of 'imdb_bloc.dart';

@immutable
abstract class ImdbEvent {}

class fetchTopMovies extends ImdbEvent {}
