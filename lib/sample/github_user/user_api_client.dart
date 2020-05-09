

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user_model.dart';

class UsersApiClient {
  static const baseUrl = 'https://5e9180702810f4001648b99f.mockapi.io/v1';
  final http.Client httpClient;

  UsersApiClient({this.httpClient})
      : assert(httpClient != null);

  Future<List<User>> fetchUsers() async {
    final List<User> allUsers = [];
    http.Response response = await httpClient.get('$baseUrl/users');
    List<dynamic> responseData = jsonDecode(response.body);

    responseData.forEach((singleUser) {
      allUsers.add(User(login: singleUser['name'], id: int.parse('${singleUser['id']}') ));
    });
    return allUsers;
  }
}