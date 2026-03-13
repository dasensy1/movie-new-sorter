import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/film_card.dart';
import '../components/sort_dropdown.dart';
import '../viewmodels/films_viewmodel.dart';

class FilmsListScreen extends StatefulWidget {
  final int? selectedFilmId;

  const FilmsListScreen({super.key, this.selectedFilmId});

  @override
  State<FilmsListScreen> createState() => _FilmsListScreenState();
}

class _FilmsListScreenState extends State<FilmsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<FilmsViewModel>();
      if (viewModel.films.isEmpty) {
        viewModel.loadFilms();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films'),
        actions: [
          Consumer<FilmsViewModel>(
            builder: (context, viewModel, _) {
              return SortDropdown(
                currentSortType: viewModel.currentSortType,
                onSortChanged: viewModel.setSortType,
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<FilmsViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading films',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    viewModel.error!,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadFilms(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.films.isEmpty) {
            return const Center(
              child: Text('No films available'),
            );
          }

          return ListView.builder(
            itemCount: viewModel.films.length,
            itemBuilder: (context, index) {
              final film = viewModel.films[index];
              return FilmCard(
                film: film,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/film',
                    arguments: film.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
