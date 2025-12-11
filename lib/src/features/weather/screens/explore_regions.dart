import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../providers/weather_provider.dart';

class ExploreRegionsScreen extends StatefulWidget {
  const ExploreRegionsScreen({super.key});

  @override
  State<ExploreRegionsScreen> createState() => _ExploreRegionsScreenState();
}

class _ExploreRegionsScreenState extends State<ExploreRegionsScreen> {
  late final List<_Region> _allRegions;
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();


    _allRegions = const [
      _Region(
        name: 'Asia',
        description: 'Popular cities across South & East Asia',
        countries: [
          _Country(
            name: 'Sri Lanka',
            code: 'LK',
            flag: '🇱🇰',
            cities: [
              _City(name: 'Colombo', countryCode: 'LK'),
              _City(name: 'Kandy', countryCode: 'LK'),
              _City(name: 'Galle', countryCode: 'LK'),
            ],
          ),
          _Country(
            name: 'India',
            code: 'IN',
            flag: '🇮🇳',
            cities: [
              _City(name: 'Chennai', countryCode: 'IN'),
              _City(name: 'Mumbai', countryCode: 'IN'),
              _City(name: 'New Delhi', countryCode: 'IN'),
            ],
          ),
          _Country(
            name: 'Japan',
            code: 'JP',
            flag: '🇯🇵',
            cities: [
              _City(name: 'Tokyo', countryCode: 'JP'),
              _City(name: 'Osaka', countryCode: 'JP'),
              _City(name: 'Kyoto', countryCode: 'JP'),
            ],
          ),
          _Country(
            name: 'China',
            code: 'CN',
            flag: '🇨🇳',
            cities: [
              _City(name: 'Beijing', countryCode: 'CN'),
              _City(name: 'Shanghai', countryCode: 'CN'),
              _City(name: 'Guangzhou', countryCode: 'CN'),
            ],
          ),
        ],
      ),

      _Region(
        name: 'Africa',
        description: 'Key cities across the African continent',
        countries: [
          _Country(
            name: 'Egypt',
            code: 'EG',
            flag: '🇪🇬',
            cities: [
              _City(name: 'Cairo', countryCode: 'EG'),
              _City(name: 'Alexandria', countryCode: 'EG'),
            ],
          ),
          _Country(
            name: 'Kenya',
            code: 'KE',
            flag: '🇰🇪',
            cities: [
              _City(name: 'Nairobi', countryCode: 'KE'),
              _City(name: 'Mombasa', countryCode: 'KE'),
            ],
          ),
          _Country(
            name: 'South Africa',
            code: 'ZA',
            flag: '🇿🇦',
            cities: [
              _City(name: 'Johannesburg', countryCode: 'ZA'),
              _City(name: 'Cape Town', countryCode: 'ZA'),
            ],
          ),
        ],
      ),

      _Region(
        name: 'Europe',
        description: 'Popular European capitals and major cities',
        countries: [
          _Country(
            name: 'United Kingdom',
            code: 'GB',
            flag: '🇬🇧',
            cities: [
              _City(name: 'London', countryCode: 'GB'),
              _City(name: 'Manchester', countryCode: 'GB'),
            ],
          ),
          _Country(
            name: 'France',
            code: 'FR',
            flag: '🇫🇷',
            cities: [
              _City(name: 'Paris', countryCode: 'FR'),
              _City(name: 'Lyon', countryCode: 'FR'),
            ],
          ),
          _Country(
            name: 'Germany',
            code: 'DE',
            flag: '🇩🇪',
            cities: [
              _City(name: 'Berlin', countryCode: 'DE'),
              _City(name: 'Munich', countryCode: 'DE'),
            ],
          ),
          _Country(
            name: 'Italy',
            code: 'IT',
            flag: '🇮🇹',
            cities: [
              _City(name: 'Rome', countryCode: 'IT'),
              _City(name: 'Milan', countryCode: 'IT'),
            ],
          ),
        ],
      ),

      _Region(
        name: 'North America',
        description: 'Key US & Canadian cities to explore',
        countries: [
          _Country(
            name: 'United States',
            code: 'US',
            flag: '🇺🇸',
            cities: [
              _City(name: 'New York', countryCode: 'US'),
              _City(name: 'Los Angeles', countryCode: 'US'),
              _City(name: 'Chicago', countryCode: 'US'),
            ],
          ),
          _Country(
            name: 'Canada',
            code: 'CA',
            flag: '🇨🇦',
            cities: [
              _City(name: 'Toronto', countryCode: 'CA'),
              _City(name: 'Vancouver', countryCode: 'CA'),
            ],
          ),
        ],
      ),

      _Region(
        name: 'South America',
        description: 'Major cities across South America',
        countries: [
          _Country(
            name: 'Brazil',
            code: 'BR',
            flag: '🇧🇷',
            cities: [
              _City(name: 'São Paulo', countryCode: 'BR'),
              _City(name: 'Rio de Janeiro', countryCode: 'BR'),
              _City(name: 'Brasília', countryCode: 'BR'),
            ],
          ),
          _Country(
            name: 'Argentina',
            code: 'AR',
            flag: '🇦🇷',
            cities: [
              _City(name: 'Buenos Aires', countryCode: 'AR'),
              _City(name: 'Córdoba', countryCode: 'AR'),
            ],
          ),
          _Country(
            name: 'Chile',
            code: 'CL',
            flag: '🇨🇱',
            cities: [
              _City(name: 'Santiago', countryCode: 'CL'),
              _City(name: 'Valparaíso', countryCode: 'CL'),
            ],
          ),
        ],
      ),

      _Region(
        name: 'Australia/Oceania',
        description: 'Popular cities in Australia & New Zealand',
        countries: [
          _Country(
            name: 'Australia',
            code: 'AU',
            flag: '🇦🇺',
            cities: [
              _City(name: 'Sydney', countryCode: 'AU'),
              _City(name: 'Melbourne', countryCode: 'AU'),
              _City(name: 'Brisbane', countryCode: 'AU'),
            ],
          ),
          _Country(
            name: 'New Zealand',
            code: 'NZ',
            flag: '🇳🇿',
            cities: [
              _City(name: 'Auckland', countryCode: 'NZ'),
              _City(name: 'Wellington', countryCode: 'NZ'),
              _City(name: 'Christchurch', countryCode: 'NZ'),
            ],
          ),
        ],
      ),

      _Region(
        name: 'Antarctica',
        description: 'Famous research stations in Antarctica',
        countries: [
          _Country(
            name: 'Research stations',
            code: 'AQ',
            flag: '🏳️', // no official flag, neutral white
            cities: [
              _City(name: 'McMurdo Station', countryCode: 'AQ'),
              _City(name: 'Amundsen-Scott Station', countryCode: 'AQ'),
            ],
          ),
        ],
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Region> get _filteredRegions {
    if (_query.trim().isEmpty) return _allRegions;
    final q = _query.toLowerCase();

    return _allRegions
        .map((region) {
      final filteredCountries = region.countries
          .map((country) {
        final matchCountryName =
            country.name.toLowerCase().contains(q) ||
                country.code.toLowerCase().contains(q);

        final filteredCities = country.cities
            .where((city) => city.name.toLowerCase().contains(q))
            .toList();

        if (matchCountryName || filteredCities.isNotEmpty) {
          return _Country(
            name: country.name,
            code: country.code,
            flag: country.flag,
            cities: matchCountryName ? country.cities : filteredCities,
          );
        }
        return null;
      })
          .whereType<_Country>()
          .toList();

      final matchRegionName = region.name.toLowerCase().contains(q);

      if (matchRegionName || filteredCountries.isNotEmpty) {
        return _Region(
          name: region.name,
          description: region.description,
          countries:
          matchRegionName ? region.countries : filteredCountries,
        );
      }
      return null;
    })
        .whereType<_Region>()
        .toList();
  }

  Future<void> _onCityTap(BuildContext context, _City city) async {
    final provider = context.read<WeatherProvider>();
    await provider.searchByCity('${city.name},${city.countryCode}');
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final regions = _filteredRegions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore By Region'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() => _query = value);
              },
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search region',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.4,
                  ),
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔵 Region header
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: AppColors.primary
                                      .withOpacity(0.10),
                                  borderRadius:
                                  BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.public_outlined,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      region.name,
                                      style: textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      region.description,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          ...region.countries.map((country) {
                            return Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12, 10, 12, 10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // 🔥 real flag emoji
                                        Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              country.flag,
                                              style: const TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${country.name} (${country.code})',
                                          style: textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            fontWeight:
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),


                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: country.cities
                                          .map((city) {
                                        return InkWell(
                                          borderRadius:
                                          BorderRadius.circular(
                                              12),
                                          onTap: () =>
                                              _onCityTap(context, city),
                                          child: Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12),
                                              border: Border.all(
                                                color: AppColors.primary,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .location_city_outlined,
                                                  size: 16,
                                                  color: AppColors
                                                      .primary,
                                                ),
                                                const SizedBox(
                                                    width: 6),
                                                Text(
                                                  city.name,
                                                  style: textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                    color: AppColors
                                                        .primary,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class _Region {
  final String name;
  final String description;
  final List<_Country> countries;

  const _Region({
    required this.name,
    required this.description,
    required this.countries,
  });
}

class _Country {
  final String name;
  final String code;
  final String flag;
  final List<_City> cities;

  const _Country({
    required this.name,
    required this.code,
    required this.flag,
    required this.cities,
  });
}

class _City {
  final String name;
  final String countryCode;

  const _City({
    required this.name,
    required this.countryCode,
  });
}
