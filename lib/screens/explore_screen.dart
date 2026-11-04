
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'song_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  // Dummy katalog lagu
  final List<Map<String, dynamic>> songs = [
    {
      'title': 'Cruel Summer',
      'artist': 'Taylor Swift',
      'album': 'Lover',
      'genre': 'Pop',
      'duration': '2:58',
      'icon': Icons.wb_sunny_rounded,
    },
    {
      'title': 'Birds of a Feather',
      'artist': 'Billie Eilish',
      'album': 'Hit Me Hard and Soft',
      'genre': 'Alternative',
      'duration': '3:30',
      'icon': Icons.flight_rounded,
    },
    {
      'title': 'Blue',
      'artist': 'Yung Kai',
      'album': 'Blue',
      'genre': 'Pop',
      'duration': '3:35',
      'icon': Icons.water_drop_rounded,
    },
    {
      'title': 'Perfect',
      'artist': 'Ed Sheeran',
      'album': 'Divide',
      'genre': 'Pop',
      'duration': '4:23',
      'icon': Icons.favorite_rounded,
    },
    {
      'title': 'Die With A Smile',
      'artist': 'Lady Gaga, Bruno Mars',
      'album': 'Die With A Smile',
      'genre': 'Pop',
      'duration': '4:11',
      'icon': Icons.favorite_border_rounded,
    },
    {
      'title': 'Somewhere Only We Know',
      'artist': 'Keane',
      'album': 'Hopes and Fears',
      'genre': 'Alternative',
      'duration': '3:57',
      'icon': Icons.nights_stay_rounded,
    },
  ];

  List<Map<String, dynamic>> get filteredSongs {
    if (searchQuery.trim().isEmpty) {
      return songs;
    }

    return songs.where((song) {
      final title = (song['title'] as String).toLowerCase();
      final artist = (song['artist'] as String).toLowerCase();

      return title.contains(searchQuery.toLowerCase()) ||
          artist.contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _openSongDetail(Map<String, dynamic> song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SongDetailScreen(
          title: song['title'] as String,
          artist: song['artist'] as String,
          album: song['album'] as String,
          genre: song['genre'] as String,
          duration: song['duration'] as String,
          icon: song['icon'] as IconData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Music'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 840;

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discover Your Music',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Find songs and explore your favorite music.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),

                          // Search field
                          TextField(
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search song or artist...',
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                              ),
                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        searchController.clear();
                                        setState(() {
                                          searchQuery = '';
                                        });
                                      },
                                      icon: const Icon(Icons.close_rounded),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular Songs',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                '${filteredSongs.length} songs',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Song list
                    Expanded(
                      child: filteredSongs.isEmpty
                          ? _buildEmptySearch()
                          : isWide
                              ? GridView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    20, 0, 20, 20,
                                  ),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 3.2,
                                  ),
                                  itemCount: filteredSongs.length,
                                  itemBuilder: (context, index) {
                                    return _buildSongCard(
                                      filteredSongs[index],
                                    );
                                  },
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.fromLTRB(
                                    20, 0, 20, 20,
                                  ),
                                  itemCount: filteredSongs.length,
                                  itemBuilder: (context, index) {
                                    return _buildSongCard(
                                      filteredSongs[index],
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Kartu lagu
  Widget _buildSongCard(Map<String, dynamic> song) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF302442),
                Color(0xFF9B7EDE),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            song['icon'] as IconData,
            color: Colors.white,
            size: 26,
          ),
        ),
        title: Text(
          song['title'] as String,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTheme.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${song['artist']} • ${song['album']}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppTheme.secondaryTextColor,
              fontSize: 12,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: AppTheme.accentColor,
        ),
        onTap: () => _openSongDetail(song),
      ),
    );
  }

  // Tampilan jika hasil pencarian kosong
  Widget _buildEmptySearch() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.music_off_rounded,
              size: 64,
              color: AppTheme.secondaryTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              'No Songs Found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with another song title or artist.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
