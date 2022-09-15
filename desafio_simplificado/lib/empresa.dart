import 'package:uuid/uuid.dart';
import 'Socio.dart';
import 'endereco.dart';

class Empresa {
  String id = Uuid().v1();
  DateTime horarioCad = DateTime.now();

  late String razaoSocial;
  late String nomeFantasia;
  late String cnpj;
  late String telefone;

  late Endereco endereco;
  late Socio socio;

  Empresa(
    this.razaoSocial,
    this.nomeFantasia,
    this.cnpj,
    this.telefone,
    this.endereco,
    this.socio,
  );

  @override
  String toString() {
    return '''
ID: $id
CPNJ: $cnpj   Data Cadastro: $horarioCad
Razão Social: $razaoSocial
Nome Fantasia: $nomeFantasia
Telefone: $telefone
Endereço: $endereco
Sócio: 
$socio
''';
  }
}
