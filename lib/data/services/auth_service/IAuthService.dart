import 'package:etkinlik_takip/data/models/auth_models/register_request_model.dart';
import 'package:etkinlik_takip/data/models/base_models/base_response_model.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';

abstract class IAuthService {
  Future<BaseResponseModel<TokenModel>?> login({required String email, required String password});
  Future<BaseResponseModel<TokenModel>?> register({required RegisterRequestModel register});
}
