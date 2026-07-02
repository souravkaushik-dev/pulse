import 'package:flutter/foundation.dart';

import '../../models/song_model.dart';
import '../../services/youtube_repository.dart';


class HomeController extends ChangeNotifier {
  HomeController({
    YoutubeRepository? repository,
  }) : _repository = repository ?? YoutubeRepository.instance;

  final YoutubeRepository _repository;

  List<SongModel> _songs = [];
  List<SongModel> get songs => _songs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadSongs(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _songs = await _repository.searchSongs(query);
    } catch (e) {
      _error = e.toString();
      _songs = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh(String query) async {
    await loadSongs(query);
  }

  void clear() {
    _songs = [];
    _error = null;
    notifyListeners();
  }
}