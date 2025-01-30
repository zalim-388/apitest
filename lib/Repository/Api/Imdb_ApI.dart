import 'dart:convert';
import 'package:apitest/Repository/Api/Api_client.dart';
import 'package:apitest/Repository/Model_class/Imdbmodel.dart';
import 'package:http/http.dart';

class ImdbApi {
  ApiClient apiclient = ApiClient();

  Future<ImdbModel> getimdb() async {
    String path = 'https://imdb236.p.rapidapi.com/imdb/tt7631058/cast';

    var body = {};
    Response response = await apiclient.invokeAPI(path, "GET", body);
    return ImdbModel.fromJson(jsonDecode(response.body));
  }
}
