import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../models/song_model.dart';
import 'song_card.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({
    super.key,
    required this.songs,
    this.onSongTap,
    this.onPlay,
  });

  final List<SongModel> songs;

  final ValueChanged<SongModel>? onSongTap;
  final ValueChanged<SongModel>? onPlay;

  @override
  Widget build(BuildContext context) {
    if (songs.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 270.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: songs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18),
        itemBuilder: (_, index) {
          final song = songs[index];

          return SongCard(
            song: song,
            onTap: () => onSongTap?.call(song),
            onPlay: () => onPlay?.call(song),
          );
        },
      ),
    );
  }
}
