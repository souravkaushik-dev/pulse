import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:liquid_glass_easy/liquid_glass_easy.dart';
import 'package:pulse/features/home/presentation/widgets/search_result.dart';
import '../../../../models/song_model.dart';
import '../../../../services/youtube_repository.dart';


class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final YoutubeRepository _repository = YoutubeRepository.instance;

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  Timer? _debounce;

  bool _loading = false;

  List<SongModel> _songs = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () => _search(value),
    );
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _songs.clear();
      });

      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      final result = await _repository.searchSongs(query);

      if (!mounted) return;

      setState(() {
        _songs = result;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _songs.clear();
      });
    }

    if (!mounted) return;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: .95,
      minChildSize: .70,
      maxChildSize: .95,
      builder: (_, scrollController) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(36.r),
          ),
          child: LiquidGlassLens(
            style: LiquidGlassStyle(
              shape: LiquidGlassShape.continuousRoundedRectangle(
                cornerRadius: 36.r,
              ),
              appearance: LiquidGlassAppearance(
                color: theme.scaffoldBackgroundColor.withOpacity(.85),
              ),
            ),
            child: Column(
              children: [

                SizedBox(height: 12.h),

                Container(
                  width: 48.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),

                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    height: 58.h,
                    child: LiquidGlassLens(
                      style: LiquidGlassStyle(
                        shape:
                        LiquidGlassShape.continuousRoundedRectangle(
                          cornerRadius: 20.r,
                        ),
                      ),
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: "Search songs...",
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: const Icon(Icons.mic_none_rounded),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                Expanded(
                  child: ScrollConfiguration(
                    behavior: const MaterialScrollBehavior().copyWith(
                      overscroll: false,
                    ),
                    child: ListView.separated(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _songs.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (_, index) {
                        return SearchResultTile(
                          song: _songs[index],
                          onTap: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}