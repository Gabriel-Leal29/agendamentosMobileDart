import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/agendamento.dart';

class MostrarDetalhesAgendamento extends StatefulWidget {
  final Agendamento agendamento;

  MostrarDetalhesAgendamento({Key? key, required this.agendamento})
    : super(key: key);

  @override
  State<StatefulWidget> createState() => _MostrarDetalhesAgendamento();
}

class _MostrarDetalhesAgendamento extends State<MostrarDetalhesAgendamento> {
  //form
  final _form = GlobalKey<FormState>();
  final _servico = TextEditingController();
  final _data = TextEditingController();
  final _contato = TextEditingController();

  //métodos
  String formatarData(DateTime data) {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(data);
  }

  excluirAgendamento() {}

  @override
  void initState() {
    super.initState();
    _servico.text = widget.agendamento.servico;
    _data.text = formatarData(widget.agendamento.data);
    _contato.text = widget.agendamento.cliente.celular;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.agendamento.cliente.nome)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _servico, //valor digitado
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Serviço',
                  prefixIcon: Icon(Icons.airline_stops_rounded),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _data,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Data',
                  prefixIcon: Icon(Icons.access_time),
                ),
                enabled: false, //desativado
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _contato,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contato do Cliente',
                  prefixIcon: Icon(Icons.add_ic_call),
                ),
                enabled: false, //desativado
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: excluirAgendamento,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.highlight_remove, size: 26,),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text('Excluir', style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
