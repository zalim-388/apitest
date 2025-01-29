import 'dart:convert';
import 'package:apitest/Repository/Api/Api_client.dart';
import 'package:apitest/Repository/Model_class/Imdbmodel.dart';
import 'package:http/http.dart';

class ImdbApi {
  Apiclient apiclient = Apiclient();

  Future<ImdbModel> getimdb() async {
    String path = 'https://imdb-top-100-movies.p.rapidapi.com/ ';

    var body = {};
    Response response = await apiclient.invokeApI(path, "GET", body);
    return ImdbModel.fromJson(jsonDecode(response.body));
  }
}
