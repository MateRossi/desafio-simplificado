import 'endereco.dart';

class Socio {
  late String nome;
  late String cpf;
  late Endereco endereco;

  Socio(
    this.nome,
    this.cpf,
    this.endereco,
  );

  @override
  String toString() {
    return '''
CPF: $cpf
Nome Completo: $nome
Endereço: $endereco''';
  }
}
