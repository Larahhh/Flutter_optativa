import 'package:app_contatinhos/controllers/autenticacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_contatinhos/controllers/contatos_controller.dart';
import 'package:app_contatinhos/models/contato.dart';

class AddEditContato extends StatefulWidget {
  final Contato? contato;

  AddEditContato({this.contato});

  @override
  _AddEditContatoState createState() => _AddEditContatoState();
}

class _AddEditContatoState extends State<AddEditContato> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _descricao = '';
  String _telefone = '';

  @override
  void initState() {
    Get.put(AuthController());
    super.initState();
    if (widget.contato != null) {
      _nome = widget.contato!.nome;
      _descricao = widget.contato!.descricao;
      _telefone = widget.contato!.telefone;
    }
  }

  void _saveContact() {
    Get.put(AuthController());
    Get.put(ContatosController());
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ContatosController contatoController = Get.find();
      if (widget.contato == null) {
        Contato newContact = Contato(
          id: 0,
          nome: _nome,
          descricao: _descricao,
          telefone: _telefone,
          usuarioId: widget.contato!.usuarioId, 
        );
        contatoController.addContact(newContact);
      } else {
        Contato updatedContact = Contato(
          id: widget.contato!.id,
          nome: _nome,
          descricao: _descricao,
          telefone: _telefone,
          usuarioId: widget.contato!.usuarioId,
        );
        contatoController.updateContact(updatedContact);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato == null ? 'Adicionar Contato' : 'Editar Contato'),
        backgroundColor: Colors.blueAccent, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                initialValue: _nome,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onSaved: (value) => _nome = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _descricao,
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                onSaved: (value) => _descricao = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _telefone,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                onSaved: (value) => _telefone = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveContact,
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.blueAccent, 
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  widget.contato == null ? 'Salvar' : 'Atualizar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
