import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/network/weather_api_client.dart';
import '../data/local_city_repository.dart';
import '../models/weather_models.dart';

enum WeatherStatus { idle, loading, success, error }


class CitySuggestion {
  final String name;
  final String country;
  final double? lat;
  final double? lon;

  CitySuggestion({
    required this.name,
    required this.country,
    this.lat,
    this.lon,
  });
}

class WeatherProvider extends ChangeNotifier {
  final WeatherApiClient _apiClient;
  final LocalCityRepository _cityRepo;

  WeatherProvider({
    WeatherApiClient? apiClient,
    LocalCityRepository? cityRepo,
  })  : _apiClient = apiClient ?? WeatherApiClient(),
        _cityRepo = cityRepo ?? LocalCityRepository();

  WeatherStatus status = WeatherStatus.idle;
  String? errorMessage;

  CurrentWeather? current;
  List<DailyForecastPoint> forecast = [];
  List<SavedCity> savedCities = [];


  String currentCityQuery = 'Colombo';


  List<CitySuggestion> suggestions = [];

  Future<void> loadInitial() async {
    await loadSavedCities();


    if (savedCities.isEmpty) {
      final now = DateTime.now();
      savedCities = [
        SavedCity(
          id: now.millisecondsSinceEpoch,
          name: 'Colombo',
          countryCode: 'LK',
          createdAt: now,
        ),
        SavedCity(
          id: now.millisecondsSinceEpoch + 1,
          name: 'London',
          countryCode: 'GB',
          createdAt: now,
        ),
        SavedCity(
          id: now.millisecondsSinceEpoch + 2,
          name: 'New York',
          countryCode: 'US',
          createdAt: now,
        ),
      ];
      await _cityRepo.saveCities(savedCities);
    }

    await searchByCity(currentCityQuery);
  }

  Future<void> loadSavedCities() async {
    savedCities = await _cityRepo.getCities();
    notifyListeners();
  }

  Future<void> searchByCity(String city) async {
    if (city.trim().isEmpty) return;

    currentCityQuery = city;
    status = WeatherStatus.loading;
    errorMessage = null;
    notifyListeners();

    try {
      final currentJson = await _apiClient.getCurrentByCity(city);
      final currentWeather = CurrentWeather.fromJson(currentJson);

      final forecastJson = await _apiClient.getDailyForecast(
        lat: currentWeather.lat,
        lon: currentWeather.lon,
      );
      final list = (forecastJson['list'] as List)
          .map((e) => DailyForecastPoint.fromJson(e))
          .toList();

      current = currentWeather;
      forecast = list;
      status = WeatherStatus.success;
    } catch (e) {
      errorMessage = e.toString();
      status = WeatherStatus.error;
    }
    notifyListeners();
  }

  Future<void> fetchSuggestions(String query) async {
    final q = query.trim();
    if (q.length < 2) {
      suggestions = [];
      notifyListeners();
      return;
    }

    try {
      final result = await _apiClient.searchCities(q);
      suggestions = result.map((json) {
        return CitySuggestion(
          name: json['name'] ?? '',
          country: json['country'] ?? '',
          lat: (json['lat'] as num?)?.toDouble(),
          lon: (json['lon'] as num?)?.toDouble(),
        );
      }).toList();
    } catch (_) {
      suggestions = [];
    }
    notifyListeners();
  }

  void clearSuggestions() {
    suggestions = [];
    notifyListeners();
  }

  List<DailyForecastPoint> get forecastByDay {
    final map = <String, DailyForecastPoint>{};
    for (final p in forecast) {
      final key = DateFormat('yyyy-MM-dd').format(p.time);
      map[key] = p;
    }
    return map.values.toList()
      ..sort((a, b) => a.time.compareTo(b.time));
  }


  Future<bool> addCity(String name, String country) async {
    final normalizedName = name.trim().toLowerCase();
    final normalizedCountry = country.trim().toLowerCase();


    final alreadyExists = savedCities.any((c) {
      final existingName = c.name.trim().toLowerCase();
      final existingCountry = (c.countryCode ?? '').trim().toLowerCase();
      if (normalizedCountry.isEmpty) {
        return existingName == normalizedName;
      }
      return existingName == normalizedName &&
          existingCountry == normalizedCountry;
    });

    if (alreadyExists) {
      return false;
    }

    final city = SavedCity(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      countryCode: country,
      createdAt: DateTime.now(),
    );
    savedCities.add(city);
    await _cityRepo.saveCities(savedCities);
    notifyListeners();
    return true;
  }



  Future<void> deleteCity(int id) async {
    savedCities.removeWhere((c) => c.id == id);
    await _cityRepo.saveCities(savedCities);
    notifyListeners();
  }

  Future<void> updateCity(SavedCity updated) async {
    final index = savedCities.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      savedCities[index] = updated;
      await _cityRepo.saveCities(savedCities);
      notifyListeners();
    }
  }

  List<String> buildAlerts() {
    final List<String> alerts = [];
    for (final p in forecastByDay) {
      if (p.maxTemp >= 32) {
        alerts.add(
          '${DateFormat('EEE, d MMM').format(p.time)}: High temperature alert – stay hydrated.',
        );
      } else if (p.minTemp <= 10) {
        alerts.add(
          '${DateFormat('EEE, d MMM').format(p.time)}: Cold day alert – keep warm.',
        );
      }
    }
    if (alerts.isEmpty) {
      alerts.add('No special weather alerts for the upcoming days.');
    }
    return alerts;
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
