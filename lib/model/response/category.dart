class Category {
  int id;
  String name;
  String imageUrl;

  Category(this.id, this.name, this.imageUrl);

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        json['id'] as int,
        json['name'] as String,
        json['imageUrl'] as String,
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
      };
}
