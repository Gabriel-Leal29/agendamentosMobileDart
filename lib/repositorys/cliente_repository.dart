import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/cliente.dart';

class ClienteRepository extends ChangeNotifier{
  List<Cliente> _clientes = [];
  final String _baseURL = 'http://10.0.2.2:8080/clientes';// rota usada

  ClienteRepository(){
    _readClientes();
  }

  _readClientes() async {
    final response = await http.get(Uri.parse(_baseURL));

    //verifica se foi o código de sucesso
    if(response.statusCode == 200){
      final List jsonList = jsonDecode(response.body); //converte json para List e o jsonDecode transforma em List
      _clientes.addAll(jsonList.map((e) => Cliente.fromJson(e))); //adiciona no array de agendamentos

      notifyListeners();
    }else{
      throw Exception('Erro ao buscar os agendamentos');
    }
  }

  List<Cliente> getClientes(){
    return _clientes;
  }
}