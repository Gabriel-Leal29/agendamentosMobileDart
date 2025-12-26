import 'package:agendamentos_mobile_dart/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

//temas de cores padrão
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: Colors.blue,

        // 🔹 AppBar padrão
        appBarTheme:  AppBarTheme(
          backgroundColor: Colors.deepPurple[800],
          foregroundColor: Colors.white, // ícones e texto
          centerTitle: true,
        ),

        // 🔹 BottomNavigationBar padrão
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.deepPurple[800],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
        ),
      ),

      home: HomePage(),
    );
  }
}