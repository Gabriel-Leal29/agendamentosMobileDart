import 'package:agendamentos_mobile_dart/models/agendamento.dart';
import 'package:agendamentos_mobile_dart/repositorys/agendamento_repository.dart';
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
  final _dataController = TextEditingController();
  late List<Cliente> clientes;
  Cliente? _clienteSelecionado;
  DateTime? _dataSelecionada;

  //métodos

  criarAgendamento() async {
    late AgendamentoRepository agendamentoRepository = context
        .read<AgendamentoRepository>();

    //agendamento que vai ser passado na requisição
    final novoAgendamento = Agendamento(
      servico: _servico.text,
      data: _dataSelecionada!,
      cliente: _clienteSelecionado!,
    );

    //verifica se deu certo a criação do agendamento
    try {
      await agendamentoRepository.createAgendamento(novoAgendamento);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agendamento criado com sucesso!')),
      );

      Navigator.pop(context);
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)), // mostra o erro retornado da API
      );
    }
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

    setState(() {
      _dataSelecionada = dataFinal;
      _dataController.text = DateFormat(
        'dd/MM/yyyy HH:mm',
        'pt_BR',
      ).format(dataFinal);
    });
  }

  @override
  Widget build(BuildContext context) {
    late ClienteRepository clienteRepository = context
        .watch<ClienteRepository>();
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
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Digite o serviço!';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              //data e hora
              TextFormField(
                controller: _dataController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Data e horário',
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(),
                ),
                onTap: selecionarDataHora,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Selecione a data e o horário!';
                  }

                  if (_dataSelecionada!.isBefore(DateTime.now())) {
                    return 'Não é permitido agendar no passado!';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),

              //botao para adicionar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //verifica os validator's do form
                    if (_form.currentState!.validate()) {
                      criarAgendamento();
                    }
                  },
                  child: Text(
                    'Adicionar agendamento',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
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
