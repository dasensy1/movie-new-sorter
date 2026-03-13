import 'package:flutter/material.dart';

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
    const MoviesPage(),
    const SearchPage(),
    const ListsPage(),
    const ReviewsPage(),
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
  const MoviesPage({super.key});

  final List<Map<String, String>> movies = const [
    {
      'title': 'Побег из Шоушенка',
      'year': '1994',
      'rating': '4.5',
      'poster': '🎬',
      'director': 'Фрэнк Дарабонт',
    },
    {
      'title': 'Крёстный отец',
      'year': '1972',
      'rating': '4.6',
      'poster': '🎬',
      'director': 'Фрэнсис Форд Коппола',
    },
    {
      'title': 'Тёмный рыцарь',
      'year': '2008',
      'rating': '4.4',
      'poster': '🦇',
      'director': 'Кристофер Нолан',
    },
    {
      'title': 'Криминальное чтиво',
      'year': '1994',
      'rating': '4.3',
      'poster': '🎬',
      'director': 'Квентин Тарантино',
    },
    {
      'title': 'Властелин колец: Возвращение короля',
      'year': '2003',
      'rating': '4.5',
      'poster': '💍',
      'director': 'Питер Джексон',
    },
    {
      'title': 'Список Шиндлера',
      'year': '1993',
      'rating': '4.4',
      'poster': '🎬',
      'director': 'Стивен Спилберг',
    },
  ];

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
                _buildSectionTitle('Популярное сейчас'),
                const SizedBox(height: 12),
                _buildHorizontalMovieList(),
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

  Widget _buildHorizontalMovieList() {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
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
                        movies[index]['poster']!,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movies[index]['title']!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFF00E054), size: 14),
                    const SizedBox(width: 4),
                    Text(
                      movies[index]['rating']!,
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

  Widget _buildMovieListItem(Map<String, String> movie) {
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
              child: Text(movie['poster']!, style: const TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${movie['year']} • ${movie['director']}',
                  style: const TextStyle(color: Colors.white60, fontSize: 13),
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
                            movie['rating']!,
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

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск фильмов'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Найти фильм...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF1C2228),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Популярные поисковые запросы',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSearchChip('Фантастика'),
                _buildSearchChip('Драма'),
                _buildSearchChip('Боевик'),
                _buildSearchChip('Комедия'),
                _buildSearchChip('Ужасы'),
                _buildSearchChip('Классика'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFF2C3540),
      side: BorderSide.none,
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    _buildStatItem('24', 'Фильма'),
                    _buildStatItem('12', 'Любимых'),
                    _buildStatItem('8', 'Списков'),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Недавняя активность',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildActivityItem('Побег из Шоушенка', 'Добавлен в избранное', '2 часа назад'),
                _buildActivityItem('Крёстный отец', 'Оценён на 4.5 ★', '5 часов назад'),
                _buildActivityItem('Тёмный рыцарь', 'Добавлен в список', '1 день назад'),
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

  Widget _buildActivityItem(String title, String action, String time) {
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
            child: const Center(child: Text('🎬', style: TextStyle(fontSize: 24))),
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
  const ListsPage({super.key});

  final List<Map<String, String>> lists = const [
    {'title': 'Любимые фильмы 2025', 'count': '42', 'icon': '❤️'},
    {'title': 'Фильмы для просмотра', 'count': '128', 'icon': '📋'},
    {'title': 'Лучшие триллеры', 'count': '35', 'icon': '😱'},
    {'title': 'Классика кино', 'count': '50', 'icon': '🎬'},
    {'title': 'Фантастика', 'count': '67', 'icon': '🚀'},
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

  Widget _buildListItem(Map<String, String> list) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2228),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(list['icon']!, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list['title']!,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  '${list['count']} фильмов',
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
  const ReviewsPage({super.key});

  final List<Map<String, String>> reviews = const [
    {
      'movie': 'Побег из Шоушенка',
      'rating': '5.0',
      'text': 'Шедевр! Лучший фильм о надежде и дружбе.',
      'date': '10 мар 2026',
    },
    {
      'movie': 'Крёстный отец',
      'rating': '4.5',
      'text': 'Великолепная игра актёров и режиссура.',
      'date': '8 мар 2026',
    },
    {
      'movie': 'Тёмный рыцарь',
      'rating': '4.0',
      'text': 'Хит Ledger великолепен в роли Джокера.',
      'date': '5 мар 2026',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
        SliverPadding(
          padding: const EdgeInsets.all(16),
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
              const Icon(Icons.movie, color: Colors.white54, size: 18),
              const SizedBox(width: 8),
              Text(
                review['movie']!,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                      review['rating']!,
                      style: const TextStyle(color: Color(0xFF00E054), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                review['date']!,
                style: TextStyle(color: Colors.white38, fontSize: 12),
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
