import 'dart:convert';
import 'package:flutter_giphy_search/config/env.dart';
import 'package:http/http.dart' as http;

const LIMIT = 19;
const BASE_URL = "https://api.giphy.com/v1/gifs";

class GifService {
  GifService();

  Future<List<Map<String, dynamic>>> getGifs(int offset, String? search) async {
    final http.Response response;
    final API_KEY = Env.giphyKey;
    final URL_TRENDING = "$BASE_URL/trending?api_key=$API_KEY&limit=$LIMIT";
    final URL_SEARCH = "$BASE_URL/search?api_key=$API_KEY&limit=$LIMIT";

    if (search == null || search.isEmpty) {
      response = await http.get(Uri.parse(URL_TRENDING));
    } else {
      response = await http.get(
        Uri.parse("$URL_SEARCH&offset=$offset&q=$search"),
      );
    }

    final Map<String, dynamic> decoded = json.decode(response.body);
    return List<Map<String, dynamic>>.from(decoded['data'] ?? []);
  }
}
