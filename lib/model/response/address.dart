import 'governorate.dart';
import 'city.dart';

class Address {
  int id;
  String buildingNo;
  String street;
  int floor;
  int department;
  String moreDescription;
  Governorate governorate;
  City city;

  Address(this.id, this.buildingNo, this.street, this.floor, this.department,
      this.moreDescription, this.governorate, this.city);

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        json['id'] as int,
        json['buildingNo'] as String,
        json['street'] as String,
        json['floor'] as int,
        json['department'] as int,
        json['moreDescription'] as String,
        json['governorate'] == null
            ? null
            : Governorate.fromJson(json['governorate'] as Map<String, dynamic>),
        json['city'] == null
            ? null
            : City.fromJson(json['city'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'buildingNo': buildingNo,
        'street': street,
        'floor': floor,
        'department': department,
        'moreDescription': moreDescription,
        'governorate': governorate.toJson(),
        'city': city.toJson(),
      };
}
