import 'dart:convert';

import 'package:apitest/Repository/Api/Api_client.dart';
import 'package:apitest/Repository/Model_class/Imdbmodel.dart';
import 'package:http/http.dart';

class ImdbApi {
  ApiClient apiclient = ApiClient();

Future<List<ImdbModel>> getimdb() async {
  String path = 'https://imdb-top-100-movies.p.rapidapi.com/';

  var body = {};
  Response response = await apiclient.invokeAPI(path, "GET", body);

  List<dynamic> jsonResponse = jsonDecode(response.body);
  return jsonResponse.map((movie) => ImdbModel.fromJson(movie)).toList();
}

}
