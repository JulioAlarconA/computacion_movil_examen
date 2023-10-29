import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examen_alarconjulio/models/proveedor.dart';

class ProveedorService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8000';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<List_proveedor> proveedor = [];
  List_proveedor? SelectProv;
  bool isLoading = true;
  bool isEditCreate = true;

  ProveedorService() {
    loadProvs();
  }
  Future loadProvs() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_list_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final provsMap = Proveedor.fromJson(response.body);
    print(response.body);
    proveedor = provsMap.listado;
    isLoading = false;
    notifyListeners();
  }

Future editOrCreateProv(List_proveedor proveedor , BuildContext context) async {
    isEditCreate = true;
    notifyListeners();
    if (proveedor.ProveedorId == 0) {
      await this.createProv(proveedor);
    } else {
      await this.updateProv(proveedor);
    }

    isEditCreate = false;
    notifyListeners();
    loadProvs();
   
  }

  Future<String> updateProv(List_proveedor prov) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_edit_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: prov.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index = proveedor
    .indexWhere((element) => element.ProveedorId == prov.ProveedorId);
    proveedor[index] = prov;

    return '';
  }

  Future createProv(List_proveedor proveedor) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_add_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    this.proveedor.add(proveedor);
    return '';
  }

  Future deleteProv(List_proveedor proveedor, BuildContext context) async {
    final url = Uri.http(
      _baseUrl,
      'ejemplos/provider_del_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: proveedor.toJson(), headers: {
      'authorization': basicAuth,
      'Content-type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    this.proveedor.clear(); //borra todo el listado
    loadProvs();
   
    return '';
  }

}
