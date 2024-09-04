import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_contatinhos/models/usuario.dart';
import 'package:app_contatinhos/services/autenticacao_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  Rxn<Usuario> usuario = Rxn<Usuario>();
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUsuario();
  }

  void _loadUsuario() async {
    String? token = await _storage.read(key: 'token');
    if (token != null) {
      usuario.value = await AutenticacaoService.getUsuario(token);
      isLoggedIn.value = true;
    }
  }

  Future<void> login(String email, String password) async {
    String? token = await AutenticacaoService.login(email, password);
    if (token != null) {
      await _storage.write(key: 'token', value: token);
      usuario.value = await AutenticacaoService.getUsuario(token);
      isLoggedIn.value = true;
    }
  }

    Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); 
    Get.offAllNamed('/login');
  }
}