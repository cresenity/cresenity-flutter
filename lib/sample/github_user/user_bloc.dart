import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'user_event.dart';
import 'user_model.dart';
import 'user_repository.dart';
import 'user_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;

  UsersBloc({@required this.usersRepository}) : assert(usersRepository != null);

  @override
  UsersState get initialState => InitialUsersState();

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    if (event is FetchUsers) {
      yield UsersLoading();
      try {
        print("do load");
        final List<User> users = await usersRepository.getUsers();
        print("do loaded");
        yield UsersLoaded(users: users);
      } catch (e) {
        print(e);
        yield UsersError();
      }
    }
  }
}