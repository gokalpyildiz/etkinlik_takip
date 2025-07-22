import 'package:equatable/equatable.dart';

class RegisterRequestModel extends Equatable {
  const RegisterRequestModel({this.userName, this.name, this.surname, this.email, this.password, this.phone, this.phoneCountryCode});
  final String? userName;
  final String? name;
  final String? surname;
  final String? phone;
  final String? phoneCountryCode;
  final String? email;
  final String? password;

  @override
  List<Object?> get props => [userName, name, surname, email, password, phone, phoneCountryCode];

  RegisterRequestModel copyWith({
    String? userName,
    String? name,
    String? surname,
    String? email,
    String? password,
    String? phone,
    String? phoneCountryCode,
  }) {
    return RegisterRequestModel(
      userName: userName ?? this.userName,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
    );
  }
}
