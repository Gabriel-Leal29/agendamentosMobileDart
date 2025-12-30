import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/cliente.dart';

class ClienteRepository extends ChangeNotifier {
  List<Cliente> _clientes = [];
  final String _baseURL = 'http://10.0.2.2:8080/clientes'; // rota usada

  ClienteRepository() {
    _readClientes();
  }

  _readClientes() async {
    final response = await http.get(Uri.parse(_baseURL));

    //verifica se foi o código de sucesso
    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response
          .body); //converte json para List e o jsonDecode transforma em List
      _clientes.addAll(jsonList.map((e) =>
          Cliente.fromJson(e))); //adiciona no array de agendamentos

      notifyListeners();
    } else {
      throw Exception('Erro ao buscar os agendamentos');
    }
  }

  createCliente(Cliente novoCliente) async {
    final response = await http.post(Uri.parse(_baseURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(novoCliente.toJson()));

    //erros e a mensagem retornada da API
    if (response.statusCode == 400 || response.statusCode == 409 || response.statusCode == 500) {
      final erro = jsonDecode(response.body)['message']; // pega a mensagem de erro da API
      throw Exception(erro.toString());
    }

    //201 = criado e 200 = ok
    if (response.statusCode == 201 || response.statusCode == 200) {
      await _readClientes();
      notifyListeners();
    } else {
      throw Exception('Erro ao criar agendamento');
    }
  }

  deleteCliente(int id) async {
    final response = await http.delete(Uri.parse(_baseURL + '/$id'));

    //erros e a mensagem retornada da API
    if (response.statusCode == 400 || response.statusCode == 409 ||
        response.statusCode == 500) {
      final erro = jsonDecode(
          response.body)['message']; // pega a mensagem de erro da API
      throw Exception(erro.toString());
    }

    //status de 200 = ok e 204 = processou com sucesso, mas nao enviou nada de volta
    if (response.statusCode == 204 || response.statusCode == 200) {
      _clientes.removeWhere((a) => a.id == id);
      notifyListeners();
    } else {
      throw Exception('Erro ao deletar agendamento');
    }
  }

  List<Cliente> getClientes() {
    return _clientes;
  }
}