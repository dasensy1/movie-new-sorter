import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:via_films/main.dart';
import 'package:via_films/services/films_service.dart';
import 'package:via_films/viewmodels/films_viewmodel.dart';

void main() {
  testWidgets('App loads films list screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<FilmsService>(create: (_) => FilmsService()),
          ChangeNotifierProxyProvider<FilmsService, FilmsViewModel>(
            create: (context) => FilmsViewModel(context.read<FilmsService>()),
            update: (context, filmsService, previous) => previous ?? FilmsViewModel(filmsService),
          ),
        ],
        child: const ViaFilmsApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Films'), findsOneWidget);
  });
}
