class Endereco {
  String logradouro = "";
  String numero = "";
  String complemento = "";
  String bairro = "";
  String estado = "";
  String cep = "";
  String cidade = "";

  Endereco(
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.estado,
    this.cep,
    this.cidade,
  );

  @override
  String toString() {
    return '''
$logradouro, $numero, $bairro, $cidade/$estado, $cep''';
  }
}
