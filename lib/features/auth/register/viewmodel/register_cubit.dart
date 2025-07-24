import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:etkinlik_takip/data/models/auth_models/register_request_model.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';
import 'package:etkinlik_takip/data/services/auth_service/IAuthService.dart';
import 'package:etkinlik_takip/data/services/auth_service/auth_service.dart';
import 'package:etkinlik_takip/product/enums/form_status_enum.dart';
import 'package:etkinlik_takip/product/functions/token_operation.dart';
import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
part 'register_state.dart';

class RegisterCubit extends BaseCubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  late IAuthService _service;

  Future<void> init() async {
    _service = AuthService.init();
    Locale locale = PlatformDispatcher.instance.locale;
    if (locale.countryCode != null) countryCode = CountryCode.fromCountryCode(locale.countryCode!);
  }

  String? name;
  String? surname;
  String? email;
  String? password;
  String? phone;
  CountryCode? countryCode;
  String? errorMessage;
  Future<void> register() async {
    var register = RegisterRequestModel(
      name: name,
      surname: surname,
      email: email,
      password: password,
      phone: phone,
      phoneCountryCode: phone == null ? null : countryCode?.dialCode,
    );
    emit(state.copyWith(formStatus: FormStatusEnum.loading));
    phone = phone?.replaceAll(' ', '');
    register = register.copyWith(phone: phone);
    var response = await _service.register(register: register);
    if (response?.data != null) {
      if (response?.data?.token == null) {
        errorMessage = response?.error?.errorMessage ?? 'Hesap oluşturulurken bir hata oluştu';
        emit(state.copyWith(formStatus: FormStatusEnum.failure));
        return;
      }
      var value = response?.data;
      if (value is TokenModel) {
        if (value.token != null) {
          TokenOperation.instance.setToken(value);
          emit(state.copyWith(formStatus: FormStatusEnum.success));
        }
      }
    } else {
      emit(state.copyWith(formStatus: FormStatusEnum.failure));
    }
  }
}
