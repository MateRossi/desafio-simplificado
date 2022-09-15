import 'dart:convert';
import 'dart:io';

import 'package:desafio_simplificado/empresa.dart';
import 'package:desafio_simplificado/endereco.dart';
import 'package:desafio_simplificado/Socio.dart';

void main(List<String> arguments) {
  List<Empresa> listEmpresas = [];
  String opcao = '1';

  print("DESAFIO SIMPLIFICADO DART - MENU");
  while (opcao != '0') {
    print("Escolha uma opção: ");
    printMenu();
    opcao = stdin.readLineSync(encoding: utf8)!;
    switch (opcao) {
      case '1':
        cadastrarEmpresa(listEmpresas);
        print(listEmpresas);
        break;
      case '2':
        print("Digite um CNPJ (apenas números):");
        String cnpj = stdin.readLineSync(encoding: utf8)!;
        String cnpjFormatado = "";
        if (!isCnpjValid(cnpj)) {
          print("CNPJ inválido.");
          break;
        } else {
          cnpjFormatado = formatCnpj(cnpj);
          print(getEmpresaByCnpj(listEmpresas, cnpjFormatado));
        }
        break;
      case '3':
        print("Digite um CPF (apenas números):");
        String cpf = stdin.readLineSync(encoding: utf8)!;
        String cpfFormatado = "";
        if (!isCpfValid(cpf)) {
          print("CPF inválido.");
          break;
        } else {
          cpfFormatado = formatCpf(cpf);
          print(getEmpresaByCpfSocio(listEmpresas, cpfFormatado));
        }
        break;
      case '4':
        print(sortAlphabetically(listEmpresas));
        break;
      case '5':
        print("Digite um ID: ");
        String id = stdin.readLineSync(encoding: utf8)!;
        print(deletarEmpresa(id, listEmpresas));
        break;
      case '0':
        break;
      default:
        print("Opção inválida.");
        break;
    }
  }
}

String deletarEmpresa(String id, List<Empresa> listEmpresas) {
  if (listEmpresas.isEmpty) {
    return "Não há empresas cadastradas.";
  }

  Empresa? aExcluir;

  for (var empresa in listEmpresas) {
    if (empresa.id == id) {
      aExcluir = empresa;
    }
  }

  if (aExcluir == null) {
    return "Não foi encontrada um empresa com o ID correspondente.";
  }

  listEmpresas.removeWhere((empresa) => empresa.id == id);
  return "Empresa removida com sucesso.";
}

String sortAlphabetically(List<Empresa> listEmpresas) {
  if (listEmpresas.isEmpty) {
    return "Não há empresas cadastradas.";
  }
  listEmpresas.sort((a, b) => a.razaoSocial.compareTo(b.razaoSocial));
  print(listEmpresas);
  return "Lista mostrada em ordem com sucesso.";
}

Empresa? getEmpresaByCpfSocio(List<Empresa> listEmpresas, String cpf) {
  if (listEmpresas.isEmpty) {
    print("Não há empresas cadastradas.");
    return null;
  }
  for (var empresa in listEmpresas) {
    if (empresa.socio.cpf == cpf) {
      return empresa;
    }
  }
  return null;
}

Empresa? getEmpresaByCnpj(List<Empresa> listEmpresas, String cnpj) {
  if (listEmpresas.isEmpty) {
    print("Não há empresas cadastradas.");
    return null;
  }
  for (var empresa in listEmpresas) {
    if (empresa.cnpj == cnpj) {
      return empresa;
    }
  }
  return null;
}

void printMenu() {
  print('''
1) Cadastrar nova empresa.
2) Buscar empresa por CNPJ.
3) Buscar empresa por CPF do sócio.
4) Listar empresas em ordem alfabética.
5) Excluir empresa por id.
0) Sair.
  ''');
}

bool isCnpjValid(String cnpj) {
  if (cnpj.length == 14) {
    return true;
  } else {
    return false;
  }
}

bool isCpfValid(String cpf) {
  if (cpf.length == 11) {
    return true;
  } else {
    return false;
  }
}

String formatCpf(String cpf) {
  String formated = "";
  formated += cpf.substring(0, 3);
  formated += ".";
  formated += cpf.substring(3, 6);
  formated += ".";
  formated += cpf.substring(6, 9);
  formated += "-";
  formated += cpf.substring(9, 11);

  return formated;
}

String formatCnpj(String cnpj) {
  String formated = "";
  formated += cnpj.substring(0, 2);
  formated += ".";
  formated += cnpj.substring(2, 5);
  formated += ".";
  formated += cnpj.substring(5, 8);
  formated += "/";
  formated += cnpj.substring(8, 12);
  formated += "-";
  formated += cnpj.substring(12, 14);

  return formated;
}

void cadastrarEmpresa(List<Empresa> listEmpresas) {
  print("CADASTRO DE NOVA EMPRESA");
  print("Digite a razão social: ");
  String razaoSocial = stdin.readLineSync(encoding: utf8)!;

  print("Digite o nome fantasia: ");
  String nomeFantasia = stdin.readLineSync(encoding: utf8)!;

  String cnpj = "";
  do {
    print("Digite o CPNJ (apenas números): ");
    cnpj = stdin.readLineSync(encoding: utf8)!;
    if (!isCnpjValid(cnpj)) {
      print("CNPJ inválido. Tente novamente.");
    }
  } while (cnpj.length != 14);
  cnpj = formatCnpj(cnpj);

  //validar telefone
  print("Digite o telefone da nova empresa (apenas números): ");
  String telefone = stdin.readLineSync(encoding: utf8)!;

  print("CADASTRO DE ENDEREÇO DA NOVA EMPRESA");
  Endereco endereco = cadastroEndereco();

  print("CADASTRO DE SÓCIO DA NOVA EMPRESA: ");
  Socio socio = cadastroSocio();

  Empresa empresa = Empresa(
    razaoSocial,
    nomeFantasia,
    cnpj,
    telefone,
    endereco,
    socio,
  );

  listEmpresas.add(empresa);
}

Socio cadastroSocio() {
  print("Digite o nome do sócio: ");
  String nome = stdin.readLineSync(encoding: utf8)!;

  String cpf = "";
  do {
    print("Digite o CPF (apenas números): ");
    cpf = stdin.readLineSync(encoding: utf8)!;
    if (!isCnpjValid(cpf)) {
      print("CPF inválido. Tente novamente.");
    }
  } while (cpf.length != 11);
  cpf = formatCpf(cpf);

  print("CADASTRO DE ENDEREÇO DE ASSOCIADO:");
  Endereco endereco = cadastroEndereco();

  return Socio(nome, cpf, endereco);
}

Endereco cadastroEndereco() {
  print("Digite o logradouro: ");
  String logradouro = stdin.readLineSync(encoding: utf8)!;

  print("Digite o número do endereço: ");
  String numero = stdin.readLineSync(encoding: utf8)!;

  print("Digite o complemento: ");
  String complemento = stdin.readLineSync(encoding: utf8)!;

  print("Digite o nome do bairro: ");
  String bairro = stdin.readLineSync(encoding: utf8)!;

  print("Digite o nome do estado: ");
  String estado = stdin.readLineSync(encoding: utf8)!;

  print("Digite o nome da cidade: ");
  String cidade = stdin.readLineSync(encoding: utf8)!;

  //validar CEP
  print("Digite o CEP (apenas números): ");
  String cep = stdin.readLineSync(encoding: utf8)!;

  return Endereco(
    logradouro,
    numero,
    complemento,
    bairro,
    estado,
    cep,
    cidade,
  );
}
