import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../components/film_card.dart';
import '../components/sort_dropdown.dart';
import '../components/loading_overlay.dart';
import '../components/gradient_logo.dart';
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
      context.read<FilmsViewModel>().loadFilms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Consumer<FilmsViewModel>(
                  builder: (context, viewModel, _) {
                    if (viewModel.isLoading) {
                      return const LoadingOverlay();
                    }

                    if (viewModel.error != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 64, color: Colors.grey[600]),
                            const SizedBox(height: 16),
                            Text(
                              'Error loading films',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              viewModel.error!,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => viewModel.loadFilms(),
                              icon: const Icon(Icons.refresh),
                              label: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (viewModel.films.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.movie_outlined, size: 64, color: Colors.grey[700]),
                            const SizedBox(height: 16),
                            Text(
                              'No films available',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => viewModel.loadFilms(),
                              icon: const Icon(Icons.refresh),
                              label: const Text('Refresh'),
                            ),
                          ],
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        ListView.builder(
                          itemCount: viewModel.films.length,
                          padding: const EdgeInsets.only(top: 16, bottom: 80),
                          itemBuilder: (context, index) {
                            final film = viewModel.films[index];
                            return FilmCard(
                              film: film,
                              onTap: () {
                                context.push('/film/${film.id}');
                              },
                              onFavorite: () {},
                              onWatchlist: () {},
                            );
                          },
                        ),
                        _buildBottomSpotlight(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          _buildVignette(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF121212),
            const Color(0xFF121212).withValues(alpha: 0.95),
            const Color(0xFF121212).withValues(alpha: 0),
          ],
        ),
      ),
      child: Column(
        children: [
          const GradientLogo(),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Films',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const Spacer(),
              Consumer<FilmsViewModel>(
                builder: (context, viewModel, _) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () => viewModel.loadFilms(),
                        icon: const Icon(Icons.refresh),
                        tooltip: 'Refresh',
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey[850],
                        ),
                      ),
                      const SizedBox(width: 8),
                      SortDropdown(
                        currentSortType: viewModel.currentSortType,
                        onSortChanged: viewModel.setSortType,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSpotlight() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF1A1A2E).withValues(alpha: 0.3),
              const Color(0xFF1A1A2E).withValues(alpha: 0.1),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVignette() {
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Colors.transparent,
              const Color(0xFF000000).withValues(alpha: 0.4),
            ],
            stops: const [0.7, 1.0],
          ),
        ),
      ),
    );
  }
}
