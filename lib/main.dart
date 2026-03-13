import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/films_service.dart';
import 'viewmodels/viewmodels.dart';
import 'utils/app_theme.dart';
import 'utils/router.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const ViaFilmsApp());
}

class ViaFilmsApp extends StatelessWidget {
  const ViaFilmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FilmsService>(
          create: (_) => FilmsService(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilmsViewModel(
            context.read<FilmsService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => MainViewModel(),
        ),
      ],
      child: MaterialApp.router(
        title: 'ViaFilms',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: router,
      ),
    );
  }
}
