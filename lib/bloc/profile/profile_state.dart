part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class UpdatingProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileUpdatedState extends ProfileState {
  final ProfileUpdateResponse response;

  ProfileUpdatedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorUpdatingProfileState extends ProfileState {
  final String message;

  ErrorUpdatingProfileState(this.message);

  @override
  List<Object> get props => [message];
}

class UpdatingPasswordState extends ProfileState {
  @override
  List<Object> get props => [];
}

class PasswordUpdatedState extends ProfileState {
  final PasswordUpdateResponse response;

  PasswordUpdatedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorUpdatingPasswordState extends ProfileState {
  final String message;

  ErrorUpdatingPasswordState(this.message);

  @override
  List<Object> get props => [message];
}
