import 'package:get/get.dart';
import 'package:app_contatinhos/models/contato.dart';
import 'package:app_contatinhos/services/contatos_service.dart';

class ContatosController extends GetxController {
  var contatos = <Contato>[].obs;

  @override
  void onInit() {
    fetchContacts();
    super.onInit();
  }

  void fetchContacts() async {
    contatos.value = await ContatosService.getContacts();
  }

  void addContact(Contato contato) async {
    await ContatosService.addContact(contato);
    fetchContacts(); 
  }

  void updateContact(Contato contato) async {
    await ContatosService.updateContact(contato);
    fetchContacts(); 
  }

  void deleteContact(int id) async {
    await ContatosService.deleteContact(id);
    fetchContacts(); 
  }
}