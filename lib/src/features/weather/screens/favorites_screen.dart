import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../models/weather_models.dart';
import '../providers/weather_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final cities = provider.savedCities;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Cities'),
      ),
      body: cities.isEmpty
          ? const Center(
        child: Text('No saved cities yet.'),
      )
          : ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: cities.length,
        itemBuilder: (context, index) {
          final SavedCity city = cities[index];
          final flagEmoji = _countryCodeToEmoji(city.countryCode);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),

              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    flagEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              title: Text(
                city.countryCode.isNotEmpty
                    ? '${city.name}, ${city.countryCode}'
                    : city.name,
              ),
              subtitle: Text(
                'Added on ${city.createdAt.toLocal().toString().substring(0, 16)}',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _IconChip(
                    tooltip: 'View weather',
                    color: AppColors.primary,
                    icon: Icons.visibility_outlined,
                    onTap: () {
                      provider.searchByCity(
                        city.countryCode.isNotEmpty
                            ? '${city.name},${city.countryCode}'
                            : city.name,
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 8),
                  _IconChip(
                    tooltip: 'Delete',
                    color: AppColors.danger,
                    icon: Icons.delete_outline,
                    onTap: () {
                      if (city.id != null) {
                        provider.deleteCity(city.id!);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class _IconChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _IconChip({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}


String _countryCodeToEmoji(String code) {
  if (code.isEmpty || code.length != 2) return '🌍';
  final upper = code.toUpperCase();
  return String.fromCharCodes(
    upper.codeUnits.map((c) => 0x1F1E6 + (c - 0x41)),
  );
}
