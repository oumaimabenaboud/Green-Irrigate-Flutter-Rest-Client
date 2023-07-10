import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class APIService {
  static Future<http.Response> fetchWeatherDataFromAPI(
      String apiUrl, String authorizationString, String date) async {
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": authorizationString,
      "Request-Date": date,
    };

    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    return response;
  }
}
