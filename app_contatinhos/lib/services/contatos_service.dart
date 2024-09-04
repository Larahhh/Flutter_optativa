import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_contatinhos/models/contato.dart';

class ContatosService {
  static const String baseUrl = 'http://191.252.222.51/';
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> _getToken() async {
    try {
      String? token = await _storage.read(key: 'token');
      return token;
    } catch (e) {
      print("Erro ao recuperar o token: $e");
      return null;
    }
  }

  static Future<List<Contato>> getContacts() async {
    final response = await http.get(
      Uri.parse('${baseUrl}contatinhos'),
      headers: {'Authorization': 'Bearer ${await _getToken()}'},
    );
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((contact) => Contato.fromJson(contact)).toList();
    }
    return [];
  }

  static Future<void> addContact(Contato contato) async {
    await http.post(
      Uri.parse('${baseUrl}contatinhos'),
      headers: {
        'Authorization': 'Bearer ${await _getToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(contato.toJson()),
    );
  }

  static Future<void> deleteContact(int id) async {
    await http.delete(
      Uri.parse('${baseUrl}contatinhos/$id'),
      headers: {'Authorization': 'Bearer ${await _getToken()}'},
    );
  }

  static Future<void> updateContact(Contato contato) async {
    await http.put(
      Uri.parse('${baseUrl}contatinhos/${contato.id}'),
      headers: {
        'Authorization': 'Bearer ${await _getToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(contato.toJson()),
    );
  }
}
