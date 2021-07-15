import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:search_snackbar_bottomsheet_flutter/src/model/album.dart';

class Network {
  static Future<List<Album>> getAlbums() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception('Failed to load contents!');
    List data = json.decode(response.body);
    List<Album> result = data.map((e) => Album.fromJson(e)).toList();
    return result;
  }  

  static Future<Album> getAlbum(int id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/albums/$id');
    final response = await http.get(url);
    if (response.statusCode != 200) throw Exception('Failed to load contents!');
    Map<String, dynamic> data = json.decode(response.body);
    return Album.fromJson(data);
  }
}
