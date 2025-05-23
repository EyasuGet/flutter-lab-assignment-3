import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class AlbumRepository {
  final http.Client httpClient;
  List<Album>? _albumsCache;
  List<Photo>? _photosCache;

  AlbumRepository({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<List<Album>> fetchAlbums() async {
    if (_albumsCache != null) return _albumsCache!;
    final response = await httpClient.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load albums');
    }
    final List<dynamic> data = json.decode(response.body);
    _albumsCache = data.map((json) => Album.fromJson(json)).toList();
    return _albumsCache!;
  }

  Future<List<Photo>> fetchPhotos() async {
    if (_photosCache != null) return _photosCache!;
    final response = await httpClient.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load photos');
    }
    final List<dynamic> data = json.decode(response.body);
    _photosCache = data.map((json) => Photo.fromJson(json)).toList();
    return _photosCache!;
  }
}