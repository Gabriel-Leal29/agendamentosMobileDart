import 'package:agendamentos_mobile_dart/pages/adicionar_agendamento.dart';
import 'package:agendamentos_mobile_dart/repositorys/agendamento_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/agendamento.dart';
import 'mostrar_detalhes_agendamento_page.dart';

class AgendamentosPage extends StatefulWidget {
  const AgendamentosPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AgendamentosPageState();
}

class _AgendamentosPageState extends State<AgendamentosPage> {
  late final AgendamentoRepository agendamentoRepository = context
      .watch<AgendamentoRepository>(); //inicia o repository
  late List<Agendamento> agendamentos =
      agendamentoRepository.agendamentos; //recebe os agendamentos da API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agendamentos'), centerTitle: true),
      body: agendamentos.isEmpty
          ? Center(
              child: Text(
                'Nenhum agendamento no momento!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: agendamentos.length,
              itemBuilder: (context, index) {
                final agendamento = agendamentos[index];

                return ListTile(
                  title: Text(agendamento.cliente.nome),
                  subtitle: Text(agendamento.dataFormatada),
                  leading: const Icon(Icons.calendar_month),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MostrarDetalhesAgendamento(agendamento: agendamento),
                    ),
                  ),
                );
              },
            ),

      //botao flutuante, o botao de adicionar agendamento
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdicionarAgendamento()),
        ),
      ),
    );
  }
}
