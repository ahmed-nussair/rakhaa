class OrderStatus {
  int id;
  String name;

  OrderStatus(this.id, this.name);

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
        json['id'] as int,
        json['name'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
