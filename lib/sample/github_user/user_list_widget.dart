


import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_api_client.dart';
import 'user_bloc.dart';
import 'user_event.dart';
import 'user_model.dart';
import 'user_repository.dart';
import 'user_state.dart';

class UserListWidget extends StatelessWidget{
  final UsersRepository usersRepository = UsersRepository(
    usersApiClient: UsersApiClient(httpClient: http.Client()),
  );
  UsersBloc _usersBloc;
  UserListWidget({Key key}): super(key: key) {

    _usersBloc = UsersBloc(usersRepository: usersRepository);
    _usersBloc.dispatch(FetchUsers());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<UsersBloc, UsersState>(
        bloc: _usersBloc,
        builder: (context, state) {

          print(state.runtimeType.toString());
          if (state is UsersLoaded) {
            return _buildListView(state.users);
          }
          if (state is UsersError) {
            return Center(
              child: Text('Error :('),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );


        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {

          _usersBloc.dispatch(FetchUsers());
        },
      ),
    );


  }

  ListView _buildListView(List<User> users) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(users[i].login),
          subtitle: Text(users[i].id.toString()),
        );
      },
      itemCount: users.length,
    );
  }

}