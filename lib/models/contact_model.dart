import 'dart:convert';

class ContactModel {
  final String? objectId;
  final String name;
  final String phoneNumber;
  final String? imgUrl;
  final String? email;
  
  ContactModel({
    this.objectId,
    required this.name,
    required this.phoneNumber,
    this.imgUrl,
    this.email,
  });

  ContactModel copyWith({
    String? objectId,
    String? name,
    String? phoneNumber,
    String? imgUrl,
    String? email,
  }) {
    return ContactModel(
      objectId: objectId ?? this.objectId,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imgUrl: imgUrl ?? this.imgUrl,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (objectId != null) {
      result.addAll({'objectId': objectId});
    }
    result.addAll({'name': name});
    result.addAll({'phoneNumber': phoneNumber});
    if (imgUrl != null) {
      result.addAll({'imgUrl': imgUrl});
    }
    if (email != null) {
      result.addAll({'email': email});
    }

    return result;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      objectId: map['objectId'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));
}
