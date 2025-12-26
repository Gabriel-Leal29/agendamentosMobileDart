import 'package:agendamentos_mobile_dart/repositorys/agendamento_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/agendamento.dart';

class AgendamentosPage extends StatefulWidget {
  const AgendamentosPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AgendamentosPageState();
}

class _AgendamentosPageState extends State<AgendamentosPage> {
  late final AgendamentoRepository agendamentoRepository;
  late List<Agendamento> agendamentos = agendamentoRepository.getAgendamentos(); // iniciação do array dos agendamentos

  //inicio as variaveis
  @override
  void initState(){
    super.initState();
    agendamentoRepository = AgendamentoRepository();
    agendamentos = agendamentoRepository.getAgendamentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: agendamentos.length,
          itemBuilder: (context, index){
          return ListTile(
            title: Text('Nome do cliente'),
            subtitle: Text('13/05/2026'),
            leading: const Icon(Icons.calendar_month),
            trailing: const Icon(Icons.chevron_right),
          );
          }
      )
    );
  }

}