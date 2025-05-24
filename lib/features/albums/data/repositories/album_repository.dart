import '../../../../core/services/api_service.dart';
import '../models/album_model.dart';
import '../models/photo_model.dart';

class AlbumRepository {
  final ApiService apiService;

  AlbumRepository({required this.apiService});

  Future<List<AlbumModel>> getAlbums() async {
    return await apiService.fetchAlbums();
  }

  Future<List<PhotoModel>> getPhotos() async {
    return await apiService.fetchPhotos();
  }
}
