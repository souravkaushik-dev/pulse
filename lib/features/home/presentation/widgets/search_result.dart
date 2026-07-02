import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../models/song_model.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    super.key,
    required this.song,
    this.onTap,
  });

  final SongModel song;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,

      contentPadding: EdgeInsets.zero,

      leading: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: CachedNetworkImage(
          imageUrl: song.thumbnail,
          width: 60.w,
          height: 60.w,
          fit: BoxFit.cover,
        ),
      ),

      title: Text(
        song.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      subtitle: Text(
        song.artist,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),

      trailing: Icon(
        Icons.play_circle_fill_rounded,
        size: 32.sp,
        color: theme.colorScheme.primary,
      ),
    );
  }
}