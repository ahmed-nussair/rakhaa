class Governorate {
  int id;
  String name;

  Governorate(this.id, this.name);

  factory Governorate.fromJson(Map<String, dynamic> json) => Governorate(
        json['id'] as int,
        json['name'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };
}
