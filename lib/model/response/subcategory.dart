class SubCategory {
  int id;
  int categoryId;
  String name;
  String imageUrl;

  SubCategory(this.id, this.categoryId, this.name, this.imageUrl);

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        json['id'] as int,
        json['categoryId'] as int,
        json['name'] as String,
        json['imageUrl'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'categoryId': categoryId,
        'name': name,
        'imageUrl': imageUrl,
      };
}
