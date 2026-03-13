import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/films_service.dart';
import 'viewmodels/films_viewmodel.dart';
import 'utils/router.dart';

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
        ChangeNotifierProxyProvider<FilmsService, FilmsViewModel>(
          create: (context) => FilmsViewModel(
            context.read<FilmsService>(),
          ),
          update: (context, filmsService, previousViewModel) {
            if (previousViewModel == null) {
              return FilmsViewModel(filmsService);
            }
            return previousViewModel;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'ViaFilms',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: const Color(0xFF1A1A2E),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1A1A2E),
            elevation: 0,
          ),
          cardTheme: CardTheme(
            color: const Color(0xFF16213E),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
