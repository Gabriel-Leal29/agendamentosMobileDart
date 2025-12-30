import 'package:agendamentos_mobile_dart/pages/clientes_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'agendamentos_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //controladores das páginas
  int _index = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        //troca o index com o setstate
        controller: _pageController,
        onPageChanged: (index){
          setState(() {
            _index = index;
          });
        },
        children: [
          AgendamentosPage(),
          ClientesPage(),
        ],
      ),
      //barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _index=index;
          });
          _pageController.jumpToPage(index); // passa a página
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Agendamentos'), // vai pra agendamentos
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'Clientes') // vai pra page de clientes
        ],
      ),
    );
  }
}