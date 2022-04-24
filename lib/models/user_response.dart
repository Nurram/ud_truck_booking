// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.email,
    required this.fullname,
    required this.phone,
    required this.wa,
    required this.birthDate,
    required this.gender,
    required this.simExpires,
    required this.nik,
    required this.address,
    required this.province,
    required this.city,
    required this.village,
  });

  String email;
  String fullname;
  String phone;
  String wa;
  String birthDate;
  String gender;
  String simExpires;
  String nik;
  String address;
  String province;
  String city;
  String village;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        email: json["email"],
        fullname: json["fullname"],
        phone: json["phone"],
        wa: json["wa"] ?? '',
        birthDate: json["birthDate"] ?? '',
        gender: json["gender"] ?? '',
        simExpires: json["simEpires"] ?? '',
        nik: json["nik"] ?? '',
        address: json["address"] ?? '',
        province: json["province"] ?? '',
        city: json["city"] ?? '',
        village: json["village"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "phone": phone,
        "wa": wa,
        "birthDate": birthDate,
        "gender": gender,
        "simEpires": simExpires,
        "nik": nik,
        "address": address,
        "province": province,
        "city": city,
        "village": village,
      };
}
