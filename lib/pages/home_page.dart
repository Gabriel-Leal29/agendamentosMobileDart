import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          AgendamentosPage(), //futura pagina dos agendamentos
        ],
      ),
      //barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Agendamentos'), // vai pra agendamentos
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Clientes') // vai pra page de clientes
        ],
      ),
    );
  }

}

class AgendamentosPage {
}