class Cliente {
  final int? id;
  final String nome;
  final String email;
  final String celular;

  Cliente({
    this.id,
    required this.nome,
    required this.email,
    required this.celular,
  });

  //converte os dados da API (json) em um objeto cliente
  //le oq a API manda
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      //mesmos nomes q vem do json
      id: json['clienteId'],
      nome: json['nomeCliente'],
      email: json['emailCliente'],
      celular: json['celularCliente'],
    );
  }

  //vai transformar o objeto em json para enviar as requisições
  Map<String, dynamic> toJson() {
    return {
      'nomeCliente': nome,
      'emailCliente': email,
      'celularCliente': celular,
    };
  }

}
