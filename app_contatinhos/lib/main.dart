import 'package:app_contatinhos/controllers/autenticacao_controller.dart';
import 'package:app_contatinhos/controllers/contatos_controller.dart';
import 'package:app_contatinhos/screens/add_edit.dart';
import 'package:app_contatinhos/screens/cadastro.dart';
import 'package:app_contatinhos/screens/contatos_screen.dart';
import 'package:app_contatinhos/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(ContatosController());
    return GetMaterialApp(
      title: 'App Contatinhos',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/contatos', page: () => ContatosScreen()),
        GetPage(name: '/cadastro', page: () => CadastroScreen()),
        GetPage(name: '/add-contact', page: () => AddEditContato()),
        GetPage(name: '/edit-contact', page: () => AddEditContato()),
      ],
    );
  }
}
