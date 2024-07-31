import 'package:comunicacao_api_rest/screens/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    if (username.isEmpty) {
      _showErrorDialog('Por favor, insira um nome de usuário.');
      return;
    }

    final String url = 'https://jsonplaceholder.typicode.com/users?username=$username';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      if (users.isNotEmpty) {
        final user = users.first;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', user['id']);
        await prefs.setString('username', user['username']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PostsScreen()),
        );
      } else {
        _showErrorDialog('Usuário não encontrado.');
      }
    } else {
      _showErrorDialog('Erro ao conectar ao servidor.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
