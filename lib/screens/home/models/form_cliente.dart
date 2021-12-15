import 'dart:convert';

import 'package:flutter_projeto/models/cliente.dart';
import 'package:http/http.dart' as http;
import 'package:reactive_forms/reactive_forms.dart';

class FormCliente {
  final FormGroup form = fb.group({
    'id': [''],
    'nome': ['', Validators.required],
    'numeroMatricula': ['', Validators.required],
    'rg': [''],
    'cpf': ['' /*, Validators.minLength(14)*/],
    'ra': [''],
    'dataNascimento': [''],
    'numeroContato': [''],
    'nomeResponsavel': [''],
    'rgResponsavel': [''],
    'cpfResponsavel': ['']
  });

  String get getId => form.control('id').value;

  Future<Cliente?> sumit() async {
    final uri = Uri.parse('http://localhost:3000/cliente/$getId');

    try {
      late final http.Response response;
      if (form.control('id').value == '') {
        response = await http.post(
          uri,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(form.value),
        );
      } else {
        response = await http.put(
          uri,
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(form.value),
        );
      }
      final result = jsonDecode(response.body) as Map;
      return Cliente.fromMap(result);
    } catch (e) {
      return null;
    }
  }
}
