import '../models/agendamento.dart';
import '../models/cliente.dart';

class AgendamentoRepository {
  //agendamento genérico, so de exemplo
  final List<Agendamento> agendamentos = [
    Agendamento(
      id: 1,
      servico: 'Corte de cabelo',
      data: DateTime(2025, 3, 19, 14, 0),
      cliente: Cliente(id: 1, nome: 'João Silva', email: 'texte@gmail.com', celular: '00 0000-0000'),
    ),
  ];

  List<Agendamento> getAgendamentos (){
    return agendamentos;
  }
}
