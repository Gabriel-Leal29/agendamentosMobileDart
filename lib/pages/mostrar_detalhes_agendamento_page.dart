import 'package:agendamentos_mobile_dart/repositorys/agendamento_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  excluirAgendamento(BuildContext context, int id) {
    final AgendamentoRepository agendamentoRepository = context
        .read<AgendamentoRepository>();
    agendamentoRepository.deleteAgendamento(id);

    Navigator.pop(context);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Excluído com sucesso!')));
  }

  Future<void> selecionarDataHora() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
      locale: const Locale('pt', 'BR'),
    );

    if (dataSelecionada == null) return;

    final horaSelecionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horaSelecionada == null) return;

    final dataFinal = DateTime(
      dataSelecionada.year,
      dataSelecionada.month,
      dataSelecionada.day,
      horaSelecionada.hour,
      horaSelecionada.minute,
    );

    _data.text = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(dataFinal);
  }

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
              //nome do serviço
              TextFormField(
                controller: _servico, //valor digitado
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Serviço',
                  prefixIcon: Icon(Icons.airline_stops_rounded),
                ),
                enabled: false,
              ),

              SizedBox(height: 16),

              //data e hora
              TextFormField(
                controller: _data,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  labelText: 'Data e horário',
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                ),
                onTap: selecionarDataHora,
              ),

              SizedBox(height: 24),

              //contato
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

              //botao para excluir
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: () =>
                      excluirAgendamento(context, widget.agendamento.id),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.highlight_remove, size: 26),
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
