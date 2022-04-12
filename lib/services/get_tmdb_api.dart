import 'package:get/get_connect.dart';
import 'package:tugasminggu6/models/movie_model.dart';

class GetTMDBapi extends GetConnect {
  static String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<MovieModel>> getApiData(int page) async {
    String endpoint =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=fdaea77ea60057357bb36c9af4a0efb7&page=1&page=$page';

    var response = await get(endpoint);

    print("RESPONSE CODE: " + response.statusCode.toString());

    if (response.statusCode == 200) {
      List<dynamic> results = response.body['results'];

      return results.map((e) => MovieModel.fromMap(e)).toList();
    } else {
      print("ERROR ON getApiData()");
      throw Exception();
    }
  }
}
