import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  YoutubeService._();

  static final YoutubeService instance = YoutubeService._();

  final YoutubeExplode _yt = YoutubeExplode();

  Future<VideoSearchList> search(String query) async {
    try {
      return await _yt.search.search(query);
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }

  Future<Video> getVideo(String videoId) async {
    try {
      return await _yt.videos.get(videoId);
    } catch (e) {
      throw Exception('Unable to fetch video: $e');
    }
  }


  Future<Uri> getAudioUrl(String videoId) async {
    try {
      final manifest =
      await _yt.videos.streams.getManifest(videoId);

      final audio = manifest.audioOnly.withHighestBitrate();

      return audio.url;
    } catch (e) {
      throw Exception('Unable to fetch audio stream: $e');
    }
  }

  void dispose() {
    _yt.close();
  }
}