class Product {
  int id;
  int categoryId;
  int subCategoryId;
  String name;
  String imageUrl;
  double price;
  double discount;

  Product(this.id, this.categoryId, this.subCategoryId, this.name,
      this.imageUrl, this.price, this.discount);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        json['id'] as int,
        json['categoryId'] as int,
        json['subCategoryId'] as int,
        json['name'] as String,
        json['imageUrl'] as String,
        json['price'].toDouble(),
        json['discount'].toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'categoryId': categoryId,
        'subCategoryId': subCategoryId,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'discount': discount,
      };
}
