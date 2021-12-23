import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unibike/model/bike_model.dart';

class ApiService {
  static final String _baseUrl = 'https://bikeindex.org:443/api/v3/';
  static final String _search = 'search?';
  static final String _page = '1';
  static final String _per_page = '50';

  Future<BikeResult> listBikes() async {
    final response = await http.get(Uri.parse(
        _baseUrl + _search + 'page=' + _page + '&per_page=' + _per_page));
    if (response.statusCode == 200) {
      print('Successful to load bikeresult');
      return BikeResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load bikeresult');
    }
  }
}
