import 'package:intl/intl.dart';
import 'cliente.dart';

class Agendamento {
  final int? id;
  final String servico;
  final DateTime data;
  final Cliente cliente;

  Agendamento({
    this.id,
    required this.servico,
    required this.data,
    required this.cliente,
  });

  //converte o json q vai receber da API em objeto Agendamento
  factory Agendamento.fromJson(Map<String, dynamic> json) {
    return Agendamento(
      //mesmos nomes q vem do json
      id: json['idAgendamento'],
      servico: json['servicoAgendamento'],
      data: DateTime.parse(json['dataAgendamento']),
      cliente: Cliente.fromJson(json['cliente']),
    );
  }

  //transforma o objeto agendamento em json pra requisicao do post
  Map<String, dynamic> toJsonCreate() {
    return {
      'clienteId': cliente.id,
      'servico': servico,
      'data': DateFormat("yyyy-MM-dd'T'HH:mm").format(data),
    };
  }

  //formatando a data do json para ficar certinho visivelmente nas telas
  String get dataFormatada {
    return DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(data);
  }
}
