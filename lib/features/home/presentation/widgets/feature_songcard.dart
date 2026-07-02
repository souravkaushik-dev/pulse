import 'package:flutter/material.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';

import '../../../../models/song_model.dart';

class FeaturedSongCard extends StatefulWidget {
  const FeaturedSongCard({
    super.key,
    required this.song,
    this.onPlay,
    this.onTap,
  });

  final SongModel song;
  final VoidCallback? onPlay;
  final VoidCallback? onTap;

  @override
  State<FeaturedSongCard> createState() => _FeaturedSongCardState();
}

class _FeaturedSongCardState extends State<FeaturedSongCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0,
      upperBound: 1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              final scale = 1 + (_controller.value * .015);

              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: AspectRatio(
                aspectRatio: .82,
                child: Hero(
                  tag: widget.song.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [

                        Image.network(
                          widget.song.thumbnail,
                          fit: BoxFit.cover,
                        ),

                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          child: SizedBox(
                            height: 78,
                            child: LiquidGlassLens(
                              style: LiquidGlassStyle(
                                shape:
                                LiquidGlassShape.continuousRoundedRectangle(
                                  cornerRadius: 28,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                child: Row(
                                  children: [

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                            widget.song.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.titleLarge,
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            widget.song.artist,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 16),

                                    IconButton.filled(
                                      onPressed: widget.onPlay,
                                      icon: const Icon(
                                        Icons.play_arrow_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
  ),
  ));
}
}