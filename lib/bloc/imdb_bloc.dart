import 'package:apitest/Repository/Api/Imdb_ApI.dart';
import 'package:apitest/Repository/Model_class/Imdbmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Imdb_event.dart';
part 'Imdb_state.dart';

class ImdbBloc extends Bloc<ImdbEvent, ImdbState> {
  ImdbApi api = ImdbApi();
  late List<ImdbModel> imdbMovies; // Change to a list

  ImdbBloc() : super(ImdbInitial()) {
    on<fetchTopMovies>((event, emit) async {
      emit(ImdbblocLoading());

      try {
        imdbMovies = await api.getimdb(); // Fetch list of movies
        emit(ImdbblocLoadied(imdbMovies)); // Pass list to state
      } catch (e) {
        print(e);
        emit(ImdbblocError());
      }
    });
  }
}
