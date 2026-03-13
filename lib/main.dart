import 'package:flutter/material.dart';
import 'data/content_data.dart';

void main() {
  runApp(const LetterboxdApp());
}

class LetterboxdApp extends StatelessWidget {
  const LetterboxdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Via Films',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00E054),
          brightness: Brightness.dark,
          background: const Color(0xFF14181C),
          surface: const Color(0xFF1C2228),
        ),
        scaffoldBackgroundColor: const Color(0xFF14181C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF14181C),
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MoviesPage(),
    const SearchPage(),
    ListsPage(),
    ReviewsPage(),
    const SettingsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        backgroundColor: const Color(0xFF1C2228),
        indicatorColor: const Color(0xFF00E054).withOpacity(0.2),
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.home, color: Color(0xFF00E054)),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.search, color: Color(0xFF00E054)),
            label: 'Поиск',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.list, color: Color(0xFF00E054)),
            label: 'Списки',
          ),
          NavigationDestination(
            icon: Icon(Icons.rate_review_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.rate_review, color: Color(0xFF00E054)),
            label: 'Рецензии',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.settings, color: Color(0xFF00E054)),
            label: 'Настройки',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.person, color: Color(0xFF00E054)),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

class MoviesPage extends StatelessWidget {
  MoviesPage({super.key});

  final List<ContentItem> movies = ContentData.getMovies();
  final List<ContentItem> series = ContentData.getSeries();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text(
            'Via Films',
            style: TextStyle(
              color: Color(0xFF00E054),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.white70),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Популярные фильмы'),
                const SizedBox(height: 12),
                _buildHorizontalContentList(movies.take(10).toList()),
                const SizedBox(height: 24),
                _buildSectionTitle('Популярные сериалы'),
                const SizedBox(height: 12),
                _buildHorizontalContentList(series.take(10).toList()),
                const SizedBox(height: 24),
                _buildSectionTitle('Недавние фильмы'),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildMovieListItem(movies[index]),
            childCount: movies.length,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHorizontalContentList(List<ContentItem> items) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3540),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        item.emoji,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      item.type == 'series' ? Icons.tv : Icons.movie,
                      color: const Color(0xFF00E054),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.rating,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieListItem(ContentItem movie) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2228),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFF2C3540),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(movie.emoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      movie.type == 'series' ? Icons.tv : Icons.movie,
                      color: Colors.white54,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${movie.year} • ${movie.director}',
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  movie.genre,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00E054).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFF00E054), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating,
                            style: const TextStyle(
                              color: Color(0xFF00E054),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.bookmark_border, color: Colors.white54, size: 18),
                    const SizedBox(width: 12),
                    const Icon(Icons.favorite_border, color: Colors.white54, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  String? _selectedGenre;
  List<ContentItem> _searchResults = [];

  final List<String> genres = ContentData.getGenres();

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty && _selectedGenre == null) {
        _searchResults = [];
      } else if (_selectedGenre != null) {
        _searchResults = ContentData.getByGenre(_selectedGenre!);
        if (query.isNotEmpty) {
          _searchResults = _searchResults
              .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        _searchResults = ContentData.search(query);
      }
    });
  }

  void _selectGenre(String? genre) {
    setState(() {
      _selectedGenre = genre;
      if (genre != null) {
        _searchResults = ContentData.getByGenre(genre);
        if (_searchQuery.isNotEmpty) {
          _searchResults = _searchResults
              .where((item) => item.title.toLowerCase().contains(_searchQuery.toLowerCase()))
              .toList();
        }
      } else {
        _performSearch(_searchQuery);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Найти фильм или сериал...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white54),
                        onPressed: () {
                          _performSearch('');
                          _selectGenre(null);
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1C2228),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FilterChip(
                  label: const Text('Все'),
                  selected: _selectedGenre == null,
                  onSelected: (selected) => _selectGenre(null),
                  backgroundColor: const Color(0xFF2C3540),
                  selectedColor: const Color(0xFF00E054).withOpacity(0.3),
                  labelStyle: TextStyle(
                    color: _selectedGenre == null ? const Color(0xFF00E054) : Colors.white70,
                  ),
                ),
                const SizedBox(width: 8),
                ...genres.map((genre) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(genre),
                    selected: _selectedGenre == genre,
                    onSelected: (selected) => _selectGenre(selected ? genre : null),
                    backgroundColor: const Color(0xFF2C3540),
                    selectedColor: const Color(0xFF00E054).withOpacity(0.3),
                    labelStyle: TextStyle(
                      color: _selectedGenre == genre ? const Color(0xFF00E054) : Colors.white70,
                    ),
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  _searchResults.isEmpty
                      ? 'Все'
                      : 'Найдено: ${_searchResults.length}',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _searchResults.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final item = _searchResults[index];
                      return _buildSearchResultItem(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64, color: Colors.white38),
          const SizedBox(height: 16),
          Text(
            'Введите запрос или выберите жанр',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'В базе ${ContentData.allContent.length} позиций',
            style: TextStyle(color: Colors.white38, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(ContentItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2228),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFF2C3540),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(item.emoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(
                      item.type == 'series' ? Icons.tv : Icons.movie,
                      color: const Color(0xFF00E054),
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.year} • ${item.genre}',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  item.director,
                  style: TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF00E054).withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Color(0xFF00E054), size: 14),
                const SizedBox(width: 4),
                Text(
                  item.rating,
                  style: const TextStyle(
                    color: Color(0xFF00E054),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = ContentData.getMovies();
    final series = ContentData.getSeries();
    final total = ContentData.allContent.length;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00E054), Color(0xFF00A040)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Color(0xFF00E054)),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Student',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '@student',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('${movies.length}', 'Фильмов'),
                    _buildStatItem('${series.length}', 'Сериалов'),
                    _buildStatItem('$total', 'Всего'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Любимые жанры',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildGenreChip('Драма', ContentData.getByGenre('Драма').length),
                    _buildGenreChip('Фантастика', ContentData.getByGenre('Фантастика').length),
                    _buildGenreChip('Боевик', ContentData.getByGenre('Боевик').length),
                    _buildGenreChip('Криминал', ContentData.getByGenre('Криминал').length),
                    _buildGenreChip('Аниме', ContentData.getByGenre('Аниме').length),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Недавняя активность',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildActivityItem('Побег из Шоушенка', 'Добавлен в избранное', '2 часа назад', '🎬'),
                _buildActivityItem('Крёстный отец', 'Оценён на 5.0 ★', '5 часов назад', '🎩'),
                _buildActivityItem('Во все тяжкие', 'Добавлен в список', '1 день назад', '🧪'),
                _buildActivityItem('Атака титанов', 'Написана рецензия', '2 дня назад', '🗿'),
                _buildActivityItem('Дюна', 'Просмотрено', '3 дня назад', '🏜️'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF00E054),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildGenreChip(String genre, int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2C3540),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            genre,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF00E054).withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: const TextStyle(color: Color(0xFF00E054), fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(String title, String action, String time, String emoji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF2C3540),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  action,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class ListsPage extends StatelessWidget {
  ListsPage({super.key});

  final List<Map<String, dynamic>> lists = [
    {'title': 'Любимые фильмы', 'count': ContentData.getMovies().length, 'icon': '❤️', 'genre': 'Все'},
    {'title': 'Фильмы для просмотра', 'count': '128', 'icon': '📋', 'genre': 'Все'},
    {'title': 'Все триллеры', 'count': ContentData.getByGenre('Триллер').length, 'icon': '😱', 'genre': 'Триллер'},
    {'title': 'Классика кино', 'count': ContentData.getByGenre('Драма').length, 'icon': '🎬', 'genre': 'Драма'},
    {'title': 'Лучшая фантастика', 'count': ContentData.getByGenre('Фантастика').length, 'icon': '🚀', 'genre': 'Фантастика'},
    {'title': 'Комедии', 'count': ContentData.getByGenre('Комедия').length, 'icon': '😂', 'genre': 'Комедия'},
    {'title': 'Ужасы', 'count': ContentData.getByGenre('Ужасы').length, 'icon': '👻', 'genre': 'Ужасы'},
    {'title': 'Боевики', 'count': ContentData.getByGenre('Боевик').length, 'icon': '💥', 'genre': 'Боевик'},
    {'title': 'Криминал', 'count': ContentData.getByGenre('Криминал').length, 'icon': '🔫', 'genre': 'Криминал'},
    {'title': 'Фэнтези', 'count': ContentData.getByGenre('Фэнтези').length, 'icon': '🐉', 'genre': 'Фэнтези'},
    {'title': 'Аниме фильмы', 'count': ContentData.getByGenre('Аниме').where((i) => i.type == 'movie').length, 'icon': '🎌', 'genre': 'Аниме'},
    {'title': 'Сериалы', 'count': ContentData.getSeries().length, 'icon': '📺', 'genre': 'Все'},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text(
            'Мои списки',
            style: TextStyle(color: Color(0xFF00E054), fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFF00E054)),
              onPressed: () {},
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildListItem(lists[index]),
              childCount: lists.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItem(Map<String, dynamic> list) {
    final count = list['count'] is int ? list['count'] : int.tryParse(list['count'].toString()) ?? 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2228),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(list['icon'] as String, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list['title'] as String,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '$count фильмов',
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white54),
        ],
      ),
    );
  }
}

class ReviewsPage extends StatelessWidget {
  ReviewsPage({super.key});

  final List<Map<String, String>> reviews = [
    {
      'movie': 'Побег из Шоушенка',
      'rating': '5.0',
      'text': 'Шедевр! Лучший фильм о надежде и дружбе. Фильм, который меняет взгляд на жизнь.',
      'date': '10 мар 2026',
      'emoji': '🎬',
    },
    {
      'movie': 'Крёстный отец',
      'rating': '5.0',
      'text': 'Великолепная игра актёров и режиссура. Классика, которая никогда не устареет.',
      'date': '8 мар 2026',
      'emoji': '🎩',
    },
    {
      'movie': 'Тёмный рыцарь',
      'rating': '4.5',
      'text': 'Хит Ledger великолепен в роли Джокера. Лучший фильм о Бэтмене.',
      'date': '5 мар 2026',
      'emoji': '🦇',
    },
    {
      'movie': 'Интерстеллар',
      'rating': '5.0',
      'text': 'Нолан снова превзошёл себя. Визуальный шедевр с глубоким смыслом.',
      'date': '1 мар 2026',
      'emoji': '🚀',
    },
    {
      'movie': 'Паразиты',
      'rating': '4.5',
      'text': 'Умный триллер с социальной сатирой. Заслуженный Оскар.',
      'date': '25 фев 2026',
      'emoji': '🏠',
    },
    {
      'movie': 'Во все тяжкие',
      'rating': '5.0',
      'text': 'Лучший сериал всех времён. Трансформация Уайта — это нечто!',
      'date': '20 фев 2026',
      'emoji': '🧪',
    },
    {
      'movie': 'Игра престолов',
      'rating': '4.0',
      'text': 'Первые 6 сезонов — шедевр. Финал подкачал, но всё равно стоит просмотра.',
      'date': '15 фев 2026',
      'emoji': '👑',
    },
    {
      'movie': 'Атака титанов',
      'rating': '5.0',
      'text': 'Аниме, которое ломает стереотипы. Невероятный сюжет и повороты.',
      'date': '10 фев 2026',
      'emoji': '🗿',
    },
    {
      'movie': 'Начало',
      'rating': '4.5',
      'text': 'Запутанный сюжет о снах. Нужно смотреть внимательно.',
      'date': '5 фев 2026',
      'emoji': '🌀',
    },
    {
      'movie': 'Матрица',
      'rating': '5.0',
      'text': 'Фильм, изменивший фантастику. Красные таблетки навсегда!',
      'date': '1 фев 2026',
      'emoji': '💊',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final allContent = ContentData.allContent;
    final totalReviews = reviews.length;
    final avgRating = reviews.fold<double>(0, (sum, r) => sum + double.parse(r['rating']!)) / totalReviews;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text(
            'Мои рецензии',
            style: TextStyle(color: Color(0xFF00E054), fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF00E054)),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1C2228),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatBox('$totalReviews', 'Рецензий'),
                Container(width: 1, height: 40, color: Colors.white24),
                _buildStatBox(avgRating.toStringAsFixed(1), 'Средний'),
                Container(width: 1, height: 40, color: Colors.white24),
                _buildStatBox('${allContent.length}', 'Фильмов'),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildReviewItem(reviews[index]),
              childCount: reviews.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF00E054),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, String> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2228),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(review['emoji']!, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['movie']!,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      review['date']!,
                      style: TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E054).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFF00E054), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      review['rating']!,
                      style: const TextStyle(color: Color(0xFF00E054), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['text']!,
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: const Text(
            'Настройки',
            style: TextStyle(color: Color(0xFF00E054), fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildSettingItem(index),
              childCount: 6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(int index) {
    final settings = [
      {'icon': Icons.account_circle, 'title': 'Аккаунт', 'subtitle': 'Управление профилем'},
      {'icon': Icons.notifications, 'title': 'Уведомления', 'subtitle': 'Настройка уведомлений'},
      {'icon': Icons.privacy_tip, 'title': 'Конфиденциальность', 'subtitle': 'Настройки приватности'},
      {'icon': Icons.palette, 'title': 'Тема', 'subtitle': 'Тёмная тема'},
      {'icon': Icons.language, 'title': 'Язык', 'subtitle': 'Русский'},
      {'icon': Icons.info, 'title': 'О приложении', 'subtitle': 'Версия 1.0.0'},
    ];

    final setting = settings[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2228),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(setting['icon'] as IconData, color: const Color(0xFF00E054), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  setting['title'] as String,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  setting['subtitle'] as String,
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white54),
        ],
      ),
    );
  }
}
