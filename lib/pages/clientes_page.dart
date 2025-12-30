import 'package:agendamentos_mobile_dart/repositorys/cliente_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cliente.dart';
import 'adicionar_cliente.dart';
import 'editar_cliente.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  // métodos
  deletarCliente(int id) async {
    final _clienteRepository = context.read<ClienteRepository>();

    try {
      await _clienteRepository.deleteCliente(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente deletado com sucesso!')),
      );
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
                'Nenhum cliente cadastrado!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: clientes.length,
              itemBuilder: (context, index) {
                final cliente = clientes[index];

                return ListTile(
                  title: Text(cliente.nome, style: TextStyle(fontSize: 20.0)),
                  subtitle: Text(cliente.celular),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarCliente(cliente: cliente,),
                          ),
                        ),
                        icon: Icon(Icons.app_registration_rounded),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => deletarCliente(cliente.id!),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
      //botao flutuante, o botao de adicionar agendamento
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdicionarCliente()),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.add)]),
      ),
    );
  }
}
