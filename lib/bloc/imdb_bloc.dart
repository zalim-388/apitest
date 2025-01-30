import 'package:apitest/Repository/Api/Imdb_ApI.dart';
import 'package:apitest/Repository/Model_class/Imdbmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'Imdb_event.dart';
part 'Imdb_state.dart';

class ImdbBloc extends Bloc<ImdbEvent, ImdbState> {
  ImdbApi api = ImdbApi();
  late ImdbModel imdbmodel;

  ImdbBloc() : super(ImdbInitial()) {
    on<fetchTopMovies>((evant, emit) async {
      emit(ImdbblocLoading());

      try {

        
        imdbmodel = await api.getimdb();
        emit(ImdbblocLoadied());
      } catch (e) {
        emit(ImdbblocError());
      }
    });
  }
}
