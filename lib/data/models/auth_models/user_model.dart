import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? userId;
  final String? name;
  final String? surname;
  final String? email;
  final String? notificationToken;
  final String? phoneCountryCode;
  final String? phone;
  final DateTime? registerDate;

  const UserModel({this.userId, this.name, this.surname, this.notificationToken, this.phoneCountryCode, this.phone, this.registerDate, this.email});
  @override
  List<Object?> get props => [userId, name, surname, notificationToken, phoneCountryCode, phone, registerDate, email];
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      name: map['name'],
      surname: map['surname'],
      notificationToken: map['notificationToken'],
      phoneCountryCode: map['phoneCountryCode'],
      phone: map['phone'],
      registerDate: (map['registerDate'] as Timestamp).toDate(),
    );
  }
  factory UserModel.fromFirestore(dynamic doc) {
    final data = doc.data();
    return UserModel(
      userId: doc.id,
      email: data['email'],
      name: data['name'],
      surname: data['surname'],
      notificationToken: data['notificationToken'],
      phoneCountryCode: data['phoneCountryCode'],
      phone: data['phone'],
      registerDate: (data['registerDate'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'surname': surname,
      'notificationToken': notificationToken,
      'phoneCountryCode': phoneCountryCode,
      'phone': phone,
      'registerDate': registerDate,
    };
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      notificationToken: json['notificationToken'] as String?,
      phoneCountryCode: json['phoneCountryCode'] as String?,
      phone: json['phone'] as String?,
      registerDate: (json['registerDate'] as Timestamp).toDate(),
    );
  }

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? surname,
    String? notificationToken,
    String? phoneCountryCode,
    String? phone,
    DateTime? registerDate,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      notificationToken: notificationToken ?? this.notificationToken,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phone: phone ?? this.phone,
      registerDate: registerDate ?? this.registerDate,
    );
  }
}
