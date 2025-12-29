import 'package:agendamentos_mobile_dart/repositorys/cliente_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/cliente.dart';

class AdicionarAgendamento extends StatefulWidget {
  AdicionarAgendamento({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdicionarAgendamentoState();
}

class _AdicionarAgendamentoState extends State<AdicionarAgendamento> {
  final _form = GlobalKey<FormState>();
  final _servico = TextEditingController();
  final _data = TextEditingController();
  late List<Cliente> clientes;
  Cliente? _clienteSelecionado;

  //métodos

  String formatarData(DateTime data) {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(data);
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
  Widget build(BuildContext context) {
    late ClienteRepository clienteRepository = context.watch<ClienteRepository>();
    final clientes = clienteRepository.getClientes();

    return Scaffold(
      appBar: AppBar(title: Text('Novo agendamento')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              //selecionando cliente
              DropdownButtonFormField<Cliente>(
                value: _clienteSelecionado,
                items: clientes.map((cliente) {
                  return DropdownMenuItem<Cliente>(
                    value: cliente,
                    child: Text(cliente.nome),
                  );
                }).toList(),
                onChanged: (cliente) {
                  setState(() {
                    _clienteSelecionado = cliente!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione um cliente';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              SizedBox(height: 16.0),

              //nome do serviço
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
            ],
          ),
        ),
      ),
    );
  }
}
