import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_contatinhos/models/usuario.dart';

class AutenticacaoService {
  static const String baseUrl = 'http://191.252.222.51/';

  static Future<String?> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('${baseUrl}login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'senha': senha}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    }
    return null;
  }


  static Future<Usuario?> getUsuario(String token) async {
    final response = await http.get(
      Uri.parse('${baseUrl}usuario'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}