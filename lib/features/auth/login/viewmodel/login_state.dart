part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({this.formStatus});
  final FormStatusEnum? formStatus;

  @override
  List<Object?> get props => [formStatus];

  LoginState copyWith({FormStatusEnum? formStatus}) {
    return LoginState(formStatus: formStatus);
  }
}
