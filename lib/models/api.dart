import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static final String _baseURL = 'http://localhost:3333';

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
    };
  }

  ///Forma de usar
  ///final result = await Api.get<?>('/cliente')
  ///Onde ? = List ou Map
  ///List se a api retorna um Array []
  ///Map se a api retorna um Json {}
  ///Caso a api retorna um Array de Jsons [{}, {}, {}] usar List mesmo assim
  ///No lugar do List ou Map tambem é possivel usar String, mas na maioria dos caso sera um List ou Map
  static Future<T> get<T>(String endpoint) async {
    //Cria a url da requisicao
    final url = Uri.parse('$_baseURL$endpoint'); // http://localhost:3333/cliente

    try {
      //Faz a requicao
      http.Response response = await http.get(url, headers: headers);

      //Se o status da responta da requisição for maior ou igual a 400 então houve um erro
      if (response.statusCode >= 400) {
        //Dispara um erro com o conteudo da responta do erro
        throw response.body.toString();
      }

      //Tenta decodificar a responta como um Map ou List
      //jsonDecode é usado para decodificar um json para o formato dynamic
      //dynamic é o formado mais generico do dart(flutter)      
      try {
        final responseBody = jsonDecode(response.body) as T;
        return responseBody;
      } catch (e) {
        final responseBody = response.body.toString() as T;
        return responseBody;
      }
    } catch (e) {
      throw '${e.toString()}';
    }
  }

  static Future<T> post<T>(String endpoint, dynamic body) async {
    //cria a url da requisicao
    final url = Uri.parse('$_baseURL$endpoint');

    try {
      //Faz a requicao
      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode >= 400) {
        throw response.body.toString();
      }

      //Decodifica a responta em um Map / List
      try {
        final responseBody = jsonDecode(response.body) as T;
        return responseBody;
      } catch (e) {
        final responseBody = response.body.toString() as T;
        return responseBody;
      }
    } catch (e) {
      throw '${e.toString()}';
    }
  }

  static Future<T> put<T>(String endpoint, dynamic body) async {
    //cria a url da requisicao
    final url = Uri.parse('$_baseURL$endpoint');

    try {
      //Faz a requicao
      http.Response response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode >= 400) {
        throw response.body.toString();
      }

      //Decodifica a responta em um Map / List
      try {
        final responseBody = jsonDecode(response.body) as T;
        return responseBody;
      } catch (e) {
        final responseBody = response.body.toString() as T;
        return responseBody;
      }
    } catch (e) {
      throw '${e.toString()}';
    }
  }
}
