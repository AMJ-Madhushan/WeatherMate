class CurrentWeather {
  final String city;
  final String countryCode;
  final double temperature;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final double lat;
  final double lon;
  final String icon;

  CurrentWeather({
    required this.city,
    required this.countryCode,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.lat,
    required this.lon,
    required this.icon,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>?;
    final wind = json['wind'] as Map<String, dynamic>?;
    final coord = json['coord'] as Map<String, dynamic>?;
    final sys = json['sys'] as Map<String, dynamic>?;
    final weatherList = json['weather'] as List?;

    final weather0 =
    (weatherList != null && weatherList.isNotEmpty) ? weatherList.first as Map<String, dynamic> : null;

    return CurrentWeather(
      city: json['name'] as String? ?? '',
      // 👇 this is the important new line
      countryCode: sys?['country'] as String? ?? '',
      temperature: (main?['temp'] as num?)?.toDouble() ?? 0.0,
      description: weather0?['description'] as String? ?? '',
      feelsLike: (main?['feels_like'] as num?)?.toDouble() ?? 0.0,
      humidity: (main?['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (wind?['speed'] as num?)?.toDouble() ?? 0.0,
      lat: (coord?['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (coord?['lon'] as num?)?.toDouble() ?? 0.0,
      icon: weather0?['icon'] as String? ?? '',
    );
  }
}

class DailyForecastPoint {
  final DateTime time;
  final double temp;
  final double minTemp;
  final double maxTemp;

  DailyForecastPoint({
    required this.time,
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
  });

  factory DailyForecastPoint.fromJson(Map<String, dynamic> json) {
    return DailyForecastPoint(
      time: DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] as int) * 1000,
        isUtc: true,
      ).toLocal(),
      temp: (json['main']['temp'] as num).toDouble(),
      minTemp: (json['main']['temp_min'] as num).toDouble(),
      maxTemp: (json['main']['temp_max'] as num).toDouble(),
    );
  }
}

class SavedCity {
  final int? id;
  final String name;
  final String countryCode;
  final DateTime createdAt;

  SavedCity({
    this.id,
    required this.name,
    required this.countryCode,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country_code': countryCode,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory SavedCity.fromMap(Map<String, dynamic> map) {
    return SavedCity(
      id: map['id'] as int?,
      name: map['name'] as String,
      countryCode: map['country_code'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
