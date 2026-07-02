import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';

import '../../../../models/song_model.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.song,
    this.onTap,
    this.onPlay,
  });

  final SongModel song;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 190.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: song.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28.r),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        song.thumbnail,
                        fit: BoxFit.cover,
                      ),

                      Positioned(
                        right: 12.w,
                        bottom: 12.h,
                        child: SizedBox(
                          width: 54.w,
                          height: 54.w,
                          child: LiquidGlassLens(
                            style: LiquidGlassStyle(
                              shape:
                              LiquidGlassShape.continuousRoundedRectangle(
                                cornerRadius: 27.r,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(27.r),
                                onTap: onPlay,
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 14.h),

            Text(
              song.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 4.h),

            Text(
              song.artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),

            SizedBox(height: 4.h),

            Text(
              _formatDuration(song.duration),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);

    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}