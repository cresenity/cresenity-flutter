import 'package:equatable/equatable.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object> get props => [];

  UsersEvent([List props = const []]) : super(props);
}

class FetchUsers extends UsersEvent {}