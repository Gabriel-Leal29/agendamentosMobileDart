import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/agendamento.dart';
import '../models/cliente.dart';
import 'package:http/http.dart' as http;

class AgendamentoRepository extends ChangeNotifier{
  final List<Agendamento> agendamentos = [];
  final String baseURL = 'http://10.0.2.2:8080/agendamentos';// rota usada

  AgendamentoRepository(){
    _readAgendamentos();
  }
  
  List<Agendamento> getAgendamentos (){
    return agendamentos;
  }

  //lê os dados da API
  _readAgendamentos() async{
    final response = await http.get(Uri.parse(baseURL)); //pega a requisição da API

    //verifica se foi o código de sucesso
    if(response.statusCode == 200){
      final List jsonList = jsonDecode(response.body); //converte json para List e o jsonDecode transforma em List
      agendamentos.addAll(jsonList.map((e) => Agendamento.fromJson(e))); //adiciona no array de agendamentos

      notifyListeners();
    }else{
      throw Exception('Erro ao buscar os agendamentos');
    }

  }
}
