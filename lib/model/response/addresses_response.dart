import 'governorate.dart';
import 'city.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddressesResponse {
  int id;
  String buildingNo;
  String street;
  int floor;
  int department;
  String moreDescription;
  Governorate governorate;
  City city;

  AddressesResponse(this.id, this.buildingNo, this.street, this.floor,
      this.department, this.moreDescription, this.governorate, this.city);

  factory AddressesResponse.fromJson(Map<String, dynamic> json) =>
      AddressesResponse(
        json['id'] as int,
        json['buildingNo'] as String,
        json['street'] as String,
        json['floor'] as int,
        json['department'] as int,
        json['moreDescription'] as String,
        json['governorate'] as Governorate,
        json['city'] as City,
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
