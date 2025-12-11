import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_constants.dart';

class WeatherApiClient {
  final http.Client _client;

  WeatherApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> getCurrentByCity(String city) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}/weather?q=$city&appid=${ApiConstants.apiKey}&units=metric',
    );
    final resp = await _client.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Failed to load weather: ${resp.statusCode}');
    }
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getDailyForecast({
    required double lat,
    required double lon,
  }) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}/forecast?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric',
    );
    final resp = await _client.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Failed to load forecast: ${resp.statusCode}');
    }
    return jsonDecode(resp.body) as Map<String, dynamic>;
  }



  Future<List<Map<String, dynamic>>> searchCities(String query) async {
    if (query.trim().isEmpty) return [];

    final uri = Uri.parse(
      'https://api.openweathermap.org/geo/1.0/direct'
          '?q=$query&limit=5&appid=${ApiConstants.apiKey}',
    );

    final resp = await _client.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Failed to search cities: ${resp.statusCode}');
    }

    final data = jsonDecode(resp.body) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }
}
