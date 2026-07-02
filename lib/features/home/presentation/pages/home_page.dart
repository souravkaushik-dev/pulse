import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../../core/controller/home_controller.dart';
import '../widgets/feature_songcard.dart';
import '../widgets/glass_search_bar.dart';
import '../widgets/greeting.dart';
import '../widgets/search_bottomsheet.dart';
import '../widgets/section_header.dart';
import '../widgets/trending_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  @override
  void initState() {
    super.initState();

    controller = HomeController();

    controller.loadSongs("Trending Music");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await controller.refresh("Trending Music");
  }

  void _openSearchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (_) {
        return const SearchBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (controller.error != null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    controller.error!,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (controller.songs.isEmpty) {
              return const Center(
                child: Text("No Songs Found"),
              );
            }

            return RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [

                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      24.w,
                      20.h,
                      24.w,
                      120.h,
                    ),

                    sliver: SliverList(
                      delegate: SliverChildListDelegate(

                        [

                          const GreetingSection(),

                          SizedBox(height: 28.h),

                          GlassSearchBar(
                            onTap: () => _openSearchSheet(context),
                          ),

                          SizedBox(height: 36.h),

                          FeaturedSongCard(
                            song: controller.songs.first,
                            onTap: () {
                              /// TODO
                            },
                            onPlay: () {
                              /// TODO
                            },
                          ),

                          SizedBox(height: 40.h),

                          const SectionHeader(
                            title: "Trending",
                          ),

                          SizedBox(height: 18.h),

                          TrendingList(
                            songs: controller.songs,
                            onSongTap: (song) {
                              /// TODO
                            },
                            onPlay: (song) {
                              /// TODO
                            },
                          ),

                          SizedBox(height: 40.h),

                          const SectionHeader(
                            title: "Recently Played",
                          ),

                          SizedBox(height: 18.h),

                          TrendingList(
                            songs: controller.songs.reversed.toList(),
                            onSongTap: (song) {},
                            onPlay: (song) {},
                          ),

                          SizedBox(height: 40.h),

                          const SectionHeader(
                            title: "Recommended",
                          ),

                          SizedBox(height: 18.h),

                          TrendingList(
                            songs: controller.songs,
                            onSongTap: (song) {},
                            onPlay: (song) {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}