import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_models.dart';

class LocalCityRepository {
  static const _keyCities = 'saved_cities_v1';

  Future<List<SavedCity>> getCities() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_keyCities) ?? [];
    return raw
        .map((s) => SavedCity.fromMap(
              Map<String, dynamic>.from(jsonDecode(s) as Map),
            ))
        .toList();
  }

  Future<void> saveCities(List<SavedCity> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final data = cities.map((c) => jsonEncode(c.toMap())).toList();
    await prefs.setStringList(_keyCities, data);
  }
}
