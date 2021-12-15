import 'dart:convert';

import 'package:http/http.dart' as http;

class Cliente {
  final int id;
  final String nome;
  final String numeroMatricula;
  final String rg;
  final String cpf;
  final String ra;
  final String dataNascimento;
  final String numeroContato;
  final String nomeResponsavel;
  final String rgResponsavel;
  final String cpfResponsavel;

  Cliente(
      {required this.id,
      required this.nome,
      required this.numeroMatricula,
      required this.rg,
      required this.cpf,
      required this.ra,
      required this.dataNascimento,
      required this.numeroContato,
      required this.nomeResponsavel,
      required this.rgResponsavel,
      required this.cpfResponsavel});

  static Cliente fromMap(Map dados) {
    return Cliente(
        id: dados['id'],
        nome: dados['nome'],
        numeroMatricula: dados['numeroMatricula'],
        rg: dados['rg'],
        cpf: dados['cpf'],
        ra: dados['ra'],
        dataNascimento: dados['dataNascimento'],
        numeroContato: dados['numeroContato'],
        nomeResponsavel: dados['nomeResponsavel'],
        rgResponsavel: dados['rgResponsavel'],
        cpfResponsavel: dados['cpfResponsavel']);
  }

  static Future<List<Cliente>> pesquisar(String nome) async {
    final uri = Uri.parse('http://localhost:3000/cliente?nome=$nome');
    print(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: {'Content-type': 'application/json'},
      );
      final result = jsonDecode(response.body) as List;
      return result.map((res) => Cliente.fromMap(res as Map)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<Cliente>> pesquisarRG(String rg) async {
    final uri = Uri.parse('http://localhost:3000/cliente?rg=$rg');
    print(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: {'Content-type': 'application/json'},
      );
      final result = jsonDecode(response.body) as List;
      return result.map((res) => Cliente.fromMap(res as Map)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<Cliente>> pesquisarCPF(String cpf) async {
    final uri = Uri.parse('http://localhost:3000/cliente?cpf=$cpf');
    print(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: {'Content-type': 'application/json'},
      );
      final result = jsonDecode(response.body) as List;
      return result.map((res) => Cliente.fromMap(res as Map)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<List<Cliente>> pesquisarRA(String ra) async {
    final uri = Uri.parse('http://localhost:3000/cliente?ra=$ra');
    print(uri.toString());
    try {
      final response = await http.get(
        uri,
        headers: {'Content-type': 'application/json'},
      );
      final result = jsonDecode(response.body) as List;
      return result.map((res) => Cliente.fromMap(res as Map)).toList();
    } catch (e) {
      return [];
    }
  }
}
