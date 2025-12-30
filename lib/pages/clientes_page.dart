import 'package:agendamentos_mobile_dart/repositorys/cliente_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cliente.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {

  // métodos
  deletarCliente(int id) async{
    final _clienteRepository = context.read<ClienteRepository>();

    try {
      await _clienteRepository.deleteCliente(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente deletado com sucesso!')),
      );
      Navigator.pop(context);
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)), // mostra o erro retornado da API
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _clienteRepository = context.watch<ClienteRepository>();
    final clientes = _clienteRepository.getClientes();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Clientes'), centerTitle: true),
      body: clientes.isEmpty
          ? Center(
              child: Text(
                'Nenhum cliente cadastrado! + ${clientes}',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];

                return ListTile(
                  title: Text(cliente.nome,style: TextStyle(fontSize: 20.0),),
                  subtitle: Text(cliente.celular),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () => null, icon: Icon(Icons.app_registration_rounded)),
                      SizedBox(width: 8),
                      IconButton(onPressed: () => deletarCliente(cliente.id), icon: Icon(Icons.delete)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
