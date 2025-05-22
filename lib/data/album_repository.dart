import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';

class AlbumRepository {
  final http.Client httpClient;

  AlbumRepository({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<List<Album>> fetchAlbums() async {
    final response = await httpClient.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load albums');
    }
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Album.fromJson(json)).toList();
  }
}