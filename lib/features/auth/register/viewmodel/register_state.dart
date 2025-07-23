part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({this.formStatus});
  final FormStatusEnum? formStatus;

  @override
  List<Object?> get props => [formStatus];

  RegisterState copyWith({FormStatusEnum? formStatus}) {
    return RegisterState(formStatus: formStatus ?? this.formStatus);
  }
}
