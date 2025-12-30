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
  @override
  Widget build(BuildContext context) {
    final ClienteRepository clienteRepository = context
        .watch<ClienteRepository>();
    List<Cliente> clientes = clienteRepository.getClientes();

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Clientes'), centerTitle: true),
      body: clientes.isEmpty
          ? Center(
              child: Text(
                'Nenhum cliente cadastrado!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];

                return ListTile(
                  title: Text(cliente.nome),
                  subtitle: Text(cliente.celular),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.app_registration_rounded),
                      SizedBox(width: 8),
                      Icon(Icons.delete)
                    ],
                  ),
                );
              },
            ),
    );
  }
}
