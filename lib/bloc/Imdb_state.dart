part of 'imdb_bloc.dart';

@immutable
abstract class ImdbState {}

class ImdbInitial extends ImdbState {}

class ImdbblocLoading extends ImdbState {}

class ImdbblocLoadied extends ImdbState {
  final List<ImdbModel> movies;
  ImdbblocLoadied(this.movies);
}


class ImdbblocError extends ImdbState {}
