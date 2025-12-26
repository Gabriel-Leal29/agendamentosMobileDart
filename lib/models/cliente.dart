class Cliente {
  final int id;
  final String nome;
  final String email;
  final String celular;

  Cliente({
    required this.id,
    required this.nome,
    required this.email,
    required this.celular,
  });


  //converte os dados da API (json) em um objeto cliente
  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      celular: json['celular'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'celular': celular,
    };
  }
}
