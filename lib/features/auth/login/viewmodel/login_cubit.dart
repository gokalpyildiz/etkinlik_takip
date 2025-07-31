import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/services/network/auth_service/auth_service.dart';
import 'package:etkinlik_takip/product/enums/form_status_enum.dart';
import 'package:etkinlik_takip/product/functions/auth_operation.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(const LoginState());

  bool isEmailTrue = true;
  bool isPasswordTrue = true;
  late AuthService _service;
  Future<void> init() async {
    _service = AuthService.init();
  }

  String? errorMessage;
  Future<bool> login({required String email, required String password}) async {
    errorMessage = null;
    emit(state.copyWith(formStatus: FormStatusEnum.loading));
    var response = await _service.login(email: email, password: password);
    if (response?.data?.token != null) {
      await AuthOperation.instance.setToken(response!.data!);
      emit(state.copyWith(formStatus: FormStatusEnum.success));
      return true;
    } else {
      errorMessage = response?.error?.errorMessage;
      emit(state.copyWith(formStatus: FormStatusEnum.failure));
      return false;
    }
  }
}
