import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  int id;
  @JsonKey(
    name: 'first_name',
  )
  String firstName;
  @JsonKey(
    name: 'last_name',
  )
  String lastName;
  String username;
  String email;
  String phone;
  String gender;
  @JsonKey(
    name: 'image_url',
  )
  String imageUrl;

  User(this.id, this.firstName, this.lastName, this.username, this.email,
      this.phone, this.gender, this.imageUrl);

  factory User.fromJson(Map<String, dynamic> json) => User(
        json['id'] as int,
        json['first_name'] as String,
        json['last_name'] as String,
        json['username'] as String,
        json['email'] as String,
        json['phone'] as String,
        json['gender'] as String,
        json['image_url'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        'phone': phone,
        'image_url': imageUrl,
      };
}
