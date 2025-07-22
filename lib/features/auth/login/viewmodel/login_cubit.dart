import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/services/auth_service/auth_service.dart';
import 'package:etkinlik_takip/product/enums/form_status_enum.dart';
import 'package:etkinlik_takip/product/functions/token_operation.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit({required this.emailController, required this.passwordController, required this.context}) : super(const LoginState());

  bool isEmailTrue = true;
  bool isPasswordTrue = true;
  final BuildContext context;
  TextEditingController emailController;
  TextEditingController passwordController;
  late AuthService _service;
  Future<void> init() async {
    _service = AuthService.init();
  }

  String? errorMessage;
  Future<bool> login() async {
    errorMessage = null;
    emit(state.copyWith(formStatus: FormStatusEnum.loading));
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    var response = await _service.login(email: email, password: password);
    if (response?.data?.token != null) {
      await TokenOperation.instance.setToken(response!.data!);
      emit(state.copyWith(formStatus: FormStatusEnum.success));
      return true;
    } else {
      errorMessage = response?.error?.errorMessage;
      emit(state.copyWith(formStatus: FormStatusEnum.failure));
      return false;
    }
  }
}
