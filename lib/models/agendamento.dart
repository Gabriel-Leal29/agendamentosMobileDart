import 'package:intl/intl.dart';
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

  //converte o json q vai receber da API, recebe String da data e converte para DateTime
  factory Agendamento.fromJson(Map<String, dynamic> json) {
    return Agendamento(
      id: json['id'],
      servico: json['servico'],
      data: DateTime.parse(json['data']),
      cliente: Cliente.fromJson(json['cliente']),
    );
  }

  String get dataFormatada =>
      DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(data);
}
