import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'user_model.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];

  UsersState([List props = const []]) : super(props);
}

class InitialUsersState extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;

  UsersLoaded({@required this.users})
      : assert(users != null),
        super([users]);
}

class UsersError extends UsersState {}