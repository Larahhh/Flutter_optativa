class Contato {
  final int id;
  final String nome;
  final String descricao;
  final String telefone;
  final int usuarioId;

  Contato({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.telefone,
    required this.usuarioId,
  });


  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      telefone: json['telefone'],
      usuarioId: json['usuarioId'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'telefone': telefone,
      'usuarioId': usuarioId,
    };
  }
}