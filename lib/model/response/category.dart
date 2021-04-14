import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Category {
  int id;
  String name;
  @JsonKey(name: 'image_url')
  String imageUrl;

  Category(this.id, this.name, this.imageUrl);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        json['id'] as int,
        json['name'] as String,
        json['image_url'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'image_url': imageUrl,
      };
}
