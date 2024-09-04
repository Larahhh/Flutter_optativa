import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_contatinhos/models/usuario.dart';

class UsuarioService {
  static const String baseUrl = 'http://191.252.222.51/';
  static final storage = FlutterSecureStorage();

  static Future<void> cadastrar(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('${baseUrl}usuario'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao criar usuário: ${response.body}');
    }
  }

  static Future<bool> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      String? token = responseData['token']; 
      if (token != null) {
        await storage.write(key: 'auth_token', value: token);
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  static Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  static Future<Usuario?> getUsuarioAtual() async {
    String? token = await storage.read(key: 'auth_token');
    if (token == null) return null;

    final response = await http.get(
      Uri.parse('${baseUrl}usuario'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar usuário atual');
    }
  }
}

