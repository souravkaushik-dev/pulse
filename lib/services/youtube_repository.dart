import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../models/song_model.dart';
import '../services/youtube_service.dart';

class YoutubeRepository {
  YoutubeRepository._();

  static final YoutubeRepository instance = YoutubeRepository._();

  final YoutubeService _service = YoutubeService.instance;

  Future<List<SongModel>> searchSongs(String query) async {
    try {
      final videos = await _service.search(query);

      return videos.map(_mapVideoToSong).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<Uri> getAudioUrl(String videoId) {
    return _service.getAudioUrl(videoId);
  }

  SongModel _mapVideoToSong(Video video) {
    final thumbnails = video.thumbnails;

    return SongModel(
      id: video.id.value,
      title: video.title,
      artist: video.author,
      duration: video.duration ?? Duration.zero,
      thumbnail: thumbnails.maxResUrl.isNotEmpty
          ? thumbnails.maxResUrl
          : thumbnails.highResUrl.isNotEmpty
          ? thumbnails.highResUrl
          : thumbnails.mediumResUrl,
    );
  }

  void dispose() {
    _service.dispose();
  }
}