import 'cliente.dart';

class Agendamento {
  final int id;
  final String servico;
  final DateTime data;
  final Cliente cliente;

  Agendamento({
    required this.id,
    required this.servico,
    required this.data,
    required this.cliente,
  });
}