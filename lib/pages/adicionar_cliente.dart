import 'package:agendamentos_mobile_dart/repositorys/cliente_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cliente.dart';

class AdicionarCliente extends StatefulWidget {
  AdicionarCliente({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdicionarClienteState();
}

class _AdicionarClienteState extends State<AdicionarCliente> {
  final _form = GlobalKey<FormState>();
  final _nomeCliente = TextEditingController();
  final _celularCliente = TextEditingController();
  final _emailCliente = TextEditingController();

  //métodos
  criarCliente() async {
    late ClienteRepository clienteRepository = context.read<
        ClienteRepository>();

    //passa o objeto cliente
    final novoCliente = Cliente(
        nome: _nomeCliente.text, email: _emailCliente.text, celular: _celularCliente.text
    );

    //verifica se deu certo a criação do agendamento
    try {
      await clienteRepository.createCliente(novoCliente);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cliente cadastrado com sucesso!')),
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
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Cliente'), centerTitle: true),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              //nome do cliente
              TextFormField(
                controller: _nomeCliente, //valor digitado
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.people),
                ),
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Digite o nome do Cliente!';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              //celular
              TextFormField(
                controller: _celularCliente, //valor digitado
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contato',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Digite o celular do cleinte!';
                  }
                  return null;
                },
              ),

              SizedBox(height: 16),

              // email
              TextFormField(
                controller: _emailCliente,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value
                      .trim()
                      .isEmpty) {
                    return 'Digite o e-mail do cliente!';
                  }
                  final email = value.trim();
                  final emailRegex = RegExp(
                    r'^[\w.-]+@([\w-]+\.)+[a-zA-Z]{2,}$',
                  );

                  if (!emailRegex.hasMatch(email)) {
                    return 'E-mail inválido';
                  }

                  return null;
                },
              ),

              SizedBox(height: 16),

              //botao para adicionar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    //verifica os validator's do form
                    if (_form.currentState!.validate()) {
                      criarCliente();
                    }
                  },
                  child: Text(
                    'Adicionar Cliente',
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
