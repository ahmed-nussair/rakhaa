class City {
  int id;
  String name;

  City(this.id, this.name);

  factory City.fromJson(Map<String, dynamic> json) => City(
        json['id'] as int,
        json['name'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
