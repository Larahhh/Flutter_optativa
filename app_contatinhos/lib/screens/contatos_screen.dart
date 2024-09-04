import 'package:app_contatinhos/controllers/autenticacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_contatinhos/controllers/contatos_controller.dart';
import 'package:app_contatinhos/models/contato.dart';

class ContatosScreen extends StatelessWidget {
  final ContatosController contatosController = Get.put(ContatosController());

  // Lista estática de contatos para demonstração
  final List<Contato> contatosEstaticos = [
    Contato(id: 1, nome: 'Alice Silva', descricao: 'Amiga de faculdade', telefone: '1234-5678', usuarioId: 1),
    Contato(id: 2, nome: 'Bob Oliveira', descricao: 'Colega de trabalho', telefone: '2345-6789', usuarioId: 1),
    Contato(id: 3, nome: 'Carol Santos', descricao: 'Vizinha', telefone: '3456-7890', usuarioId: 1),
  ];

  void _logout() {
    Get.put(AuthController());
    final authController = Get.find<AuthController>();
    authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 34, 88), 
      appBar: AppBar(
        title: Text('Meus Contatos'),
        backgroundColor: Colors.blueAccent, // Cor de fundo azul
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-contact');
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: Obx(() {
        List<Contato> contatos = contatosController.contatos.isEmpty
            ? contatosEstaticos 
            : contatosController.contatos;

        if (contatos.isEmpty) {
          return Center(
            child: Text(
              'Nenhum contato encontrado',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: contatos.length,
          itemBuilder: (context, index) {
            Contato contato = contatos[index];
            return Card(
              elevation: 4.0, 
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  contato.nome,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  contato.descricao,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/edit-contact',
                          arguments: contato,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        contatosController.deleteContact(contato.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
