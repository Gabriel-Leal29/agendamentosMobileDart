import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/agendamento.dart';

class MostrarDetalhesAgendamento extends StatefulWidget {
  final Agendamento agendamento;

  MostrarDetalhesAgendamento({Key? key, required this.agendamento}) : super(key:key);

  @override
  State<StatefulWidget> createState()  => _MostrarDetalhesAgendamento();
}

class _MostrarDetalhesAgendamento extends State<MostrarDetalhesAgendamento>{

  //métodos
  String formatarData(DateTime data) {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agendamento.cliente.nome),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.agendamento.servico),
          Text(widget.agendamento.cliente.celular),
          Text(formatarData(widget.agendamento.data)),
        ],
      ),
    );
  }

}
