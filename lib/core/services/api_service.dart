import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/albums/data/models/album_model.dart';
import '../../features/albums/data/models/photo_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<AlbumModel>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$_baseUrl/albums'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => AlbumModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<List<PhotoModel>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$_baseUrl/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => PhotoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
