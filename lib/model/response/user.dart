import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  int id;
  String name;
  String username;
  String email;
  String phone;
  @JsonKey(
    name: 'image_Url',
  )
  String imageUrl;

  User(
      this.id, this.name, this.username, this.email, this.phone, this.imageUrl);

  factory User.fromJson(Map<String, dynamic> json) => User(
    json['id'] as int,
        json['name'] as String,
        json['username'] as String,
        json['email'] as String,
        json['phone'] as String,
        json['image_Url'] as String,
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'phone': phone,
        'image_Url': imageUrl,
      };
}
