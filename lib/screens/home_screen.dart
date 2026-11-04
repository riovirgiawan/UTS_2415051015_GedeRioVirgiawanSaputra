
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Dummy data statistik
  final int totalSongs = 24;
  final double averageRating = 4.5;

  // Dummy data aktivitas musik
  static const List<Map<String, dynamic>> recentActivities = [
    {
      'title': 'Cruel Summer',
      'artist': 'Taylor Swift',
      'date': 'Today',
      'rating': 5,
      'mood': 'Happy',
      'icon': Icons.favorite_rounded,
    },
    {
      'title': 'Blue',
      'artist': 'Yung Kai',
      'date': 'Yesterday',
      'rating': 4,
      'mood': 'Calm',
      'icon': Icons.spa_rounded,
    },
    {
      'title': 'Birds of a Feather',
      'artist': 'Billie Eilish',
      'date': '2 days ago',
      'rating': 5,
      'mood': 'Relaxed',
      'icon': Icons.nightlight_round,
    },
  ];

  // Dummy data mood
  static const List<Map<String, dynamic>> moodData = [
    {
      'mood': 'Happy',
      'count': 12,
      'icon': Icons.sentiment_very_satisfied_rounded,
    },
    {
      'mood': 'Calm',
      'count': 8,
      'icon': Icons.spa_rounded,
    },
    {
      'mood': 'Sad',
      'count': 4,
      'icon': Icons.sentiment_dissatisfied_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.music_note_rounded,
              color: AppTheme.primaryColor,
            ),
            SizedBox(width: 8),
            Text(
              'MelodyLog',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 840;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeSection(context),

                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        context,
                        'Your Music Overview',
                        'A little summary of your music journey',
                      ),

                      const SizedBox(height: 16),

                      _buildStatistics(isWide),

                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        context,
                        'Your Listening Mood',
                        'The moods behind your music',
                      ),

                      const SizedBox(height: 16),

                      _buildMoodOverview(),

                      const SizedBox(height: 28),

                      _buildSectionTitle(
                        context,
                        'Recent Activity',
                        'Your latest music memories',
                      ),

                      const SizedBox(height: 16),

                      _buildRecentActivities(),

                      const SizedBox(height: 28),

                      _buildQuickActions(context),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Header sapaan pengguna
  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF302442),
            Color(0xFF211C2B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WELCOME BACK!',
            style: TextStyle(
              color: AppTheme.accentColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'Your Music, Your Memories.',
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 8),

          Text(
            'Keep every song and the memories behind it.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 20),

          const Row(
            children: [
              Icon(
                Icons.headphones_rounded,
                color: AppTheme.accentColor,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Every song tells a story.',
                style: TextStyle(
                  color: AppTheme.accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Judul setiap bagian dashboard
  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  // Kartu statistik
  Widget _buildStatistics(bool isWide) {
    return GridView.count(
      crossAxisCount: isWide ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: isWide ? 1.5 : 1.35,
      children: [
        _buildStatCard(
          title: 'Total Songs',
          value: '$totalSongs',
          subtitle: 'Songs recorded',
          icon: Icons.library_music_rounded,
        ),
        _buildStatCard(
          title: 'Average Rating',
          value: averageRating.toString(),
          subtitle: 'Out of 5 stars',
          icon: Icons.star_rounded,
        ),
        _buildStatCard(
          title: 'Favorite Mood',
          value: 'Happy',
          subtitle: 'Your top mood',
          icon: Icons.mood_rounded,
        ),
        _buildStatCard(
          title: 'This Month',
          value: '8',
          subtitle: 'Songs recorded',
          icon: Icons.calendar_month_rounded,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: AppTheme.accentColor,
              size: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppTheme.secondaryTextColor,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Ringkasan mood
  Widget _buildMoodOverview() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: moodData.map((item) {
            final int count = item['count'] as int;
            final double percentage = count / totalSongs;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: AppTheme.accentColor,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item['mood'] as String,
                          style: const TextStyle(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '$count songs',
                        style: const TextStyle(
                          color: AppTheme.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      backgroundColor: AppTheme.backgroundColor,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Daftar aktivitas musik terbaru
  Widget _buildRecentActivities() {
    return Column(
      children: recentActivities.map((activity) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                activity['icon'] as IconData,
                color: AppTheme.accentColor,
              ),
            ),
            title: Text(
              activity['title'] as String,
              style: const TextStyle(
                color: AppTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${activity['artist']} • ${activity['date']}',
                style: const TextStyle(
                  color: AppTheme.secondaryTextColor,
                  fontSize: 12,
                ),
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: AppTheme.accentColor,
                  size: 18,
                ),
                Text(
                  '${activity['rating']}/5',
                  style: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Tombol akses cepat
  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search_rounded),
                label: const Text('Explore Music'),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.book_rounded),
                label: const Text('My Diary'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.accentColor,
                  side: const BorderSide(
                    color: AppTheme.primaryColor,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
