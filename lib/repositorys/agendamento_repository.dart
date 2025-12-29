import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/agendamento.dart';
import 'package:http/http.dart' as http;

class AgendamentoRepository extends ChangeNotifier{
  final List<Agendamento> _agendamentos = [];
  final String _baseURL = 'http://10.0.2.2:8080/agendamentos';// rota usada

  AgendamentoRepository(){
    _readAgendamentos();
  }
  
  List<Agendamento> getAgendamentos (){
    return _agendamentos;
  }

  //lê os dados da API
  _readAgendamentos() async{
    final response = await http.get(Uri.parse(_baseURL)); //pega a requisição da API

    //verifica se foi o código de sucesso
    if(response.statusCode == 200){
      final List jsonList = jsonDecode(response.body); //converte json para List e o jsonDecode transforma em List
      _agendamentos.addAll(jsonList.map((e) => Agendamento.fromJson(e))); //adiciona no array de agendamentos

      notifyListeners();
    }else{
      throw Exception('Erro ao buscar os agendamentos');
    }
  }

  //deleta o agendamento
  deleteAgendamento(int id) async{
    final response = await http.delete(Uri.parse(_baseURL+'/$id'));

    //status de 200 = ok e 204 = processou com sucesso, mas nao enviou nada de volta
    if (response.statusCode == 204 || response.statusCode == 200) {
      _agendamentos.removeWhere((a) => a.id == id);
      notifyListeners();
    } else {
      throw Exception('Erro ao deletar agendamento');
    }
  }

}
