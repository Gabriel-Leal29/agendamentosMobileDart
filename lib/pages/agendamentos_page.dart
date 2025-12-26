import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgendamentosPage extends StatefulWidget {
  const AgendamentosPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AgendamentosPageState();
}

class _AgendamentosPageState extends State<AgendamentosPage> {
  // late List<Agendamento> agendamentos = []; // iniciação do array dos agendamentos


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agendamentos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 2, //agendamentos.length
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