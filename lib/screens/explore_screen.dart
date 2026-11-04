import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';
import '../providers/song_provider.dart';
import 'song_detail_screen.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController searchController = TextEditingController();

  Timer? debounce;

  void _onSearchChanged(String query) {
    debounce?.cancel();

    if (query.trim().isEmpty) {
      context.read<SongProvider>().clearSearch();
      return;
    }

    debounce = Timer(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      context.read<SongProvider>().searchSongs(query);
    });
  }

  void _openSongDetail(Song song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SongDetailScreen(song: song),
      ),
    );
  }

  @override
  void dispose() {
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Music'),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 840;

          return Consumer<SongProvider>(
            builder: (context, provider, child) {
              return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 1100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Discover Your Music',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Find songs and add your memories to MelodyLog.',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.65),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Search field
                    TextField(
                      controller: searchController,
                      onChanged: _onSearchChanged,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search song or artist...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                searchController.clear();
                                context.read<SongProvider>().clearSearch();
                                setState(() {});
                              },
                            )
                          : null,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Section heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Search Results',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (provider.songs.isNotEmpty)
                          Text(
                            '${provider.songs.length} songs',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Loading state
                    if (provider.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: CircularProgressIndicator(),
                        ),
                      )

                    // Error state
                    else if (provider.error != null)
                      _buildErrorState(
                        context,
                        provider,
                      )

                    // Empty state
                    else if (provider.songs.isEmpty)
                      _buildEmptyState(
                        context,
                        provider.hasSearched,
                      )

                    // Search results
                    else if (isWide)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.songs.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth >= 1100 ? 3 : 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 12,
                          childAspectRatio: 3.2,
                        ),
                        itemBuilder: (context, index) {
                          return _buildSongCard(
                            context,
                            provider.songs[index],
                          );
                        },
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.songs.length,
                        itemBuilder: (context, index) {
                          return _buildSongCard(
                            context,
                            provider.songs[index],
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSongCard(BuildContext context, Song song) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 58,
            height: 58,
            child: song.artworkUrl != null
                ? Image.network(
                    song.artworkUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildArtworkPlaceholder(context);
                    },
                  )
                : _buildArtworkPlaceholder(context),
          ),
        ),
        title: Text(
          song.trackName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${song.artistName} • ${song.formattedDuration}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _openSongDetail(song),
      ),
    );
  }

  Widget _buildArtworkPlaceholder(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
      child: Icon(
        Icons.music_note,
        color: Theme.of(context).colorScheme.primary,
        size: 30,
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    bool hasSearched,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          children: [
            Icon(
              hasSearched
                  ? Icons.search_off
                  : Icons.library_music_outlined,
              size: 56,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              hasSearched
                  ? 'No Songs Found'
                  : 'Start Exploring Music',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasSearched
                  ? 'Try searching with another keyword.'
                  : 'Search for your favorite song or artist.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    SongProvider provider,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          children: [
            const Icon(
              Icons.cloud_off,
              size: 52,
            ),
            const SizedBox(height: 12),
            const Text(
              'Something Went Wrong',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              provider.error!,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                provider.retrySearch();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}