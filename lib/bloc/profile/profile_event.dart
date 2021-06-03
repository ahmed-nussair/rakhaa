part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class UpdatingProfile extends ProfileEvent {
  final String image;
  final String name;
  final String email;
  final String phone;
  final String token;

  UpdatingProfile(
    this.token,
    this.name,
    this.email,
    this.phone, {
    this.image,
  });

  @override
  List<Object> get props => [
        image,
        name,
        email,
        phone,
        token,
      ];
}

class UpdatingPassword extends ProfileEvent {
  final String token;
  final String oldPassword;
  final String newPassword;

  UpdatingPassword(this.token, this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [token, oldPassword, newPassword];
}
