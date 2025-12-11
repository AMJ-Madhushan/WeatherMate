import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'src/core/theme/app_theme.dart';
import 'src/features/weather/providers/weather_provider.dart';
import 'src/features/weather/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WeatherMateApp());
}

class WeatherMateApp extends StatelessWidget {
  const WeatherMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      brightness: Brightness.light,
    );

    final textTheme = GoogleFonts.poppinsTextTheme(baseTheme.textTheme);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider()..loadInitial(),
        ),
      ],
      child: MaterialApp(
        title: 'WeatherMate',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.buildTheme(baseTheme, textTheme),
        home: const HomeScreen(),
      ),
    );
  }
}
