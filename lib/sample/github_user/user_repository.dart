import 'dart:async';
import 'package:meta/meta.dart';

import 'user_api_client.dart';
import 'user_model.dart';


class UsersRepository {
  final UsersApiClient usersApiClient;

  UsersRepository({@required this.usersApiClient})
      : assert(usersApiClient != null);

  Future<List<User>> getUsers() async {
    return await usersApiClient.fetchUsers();
  }
}