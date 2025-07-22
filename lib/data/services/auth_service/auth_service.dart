import 'package:etkinlik_takip/data/models/base_models/base_response_model.dart';
import 'package:etkinlik_takip/data/models/base_models/error_model.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';
import 'package:etkinlik_takip/data/services/auth_service/IAuthService.dart';
import 'package:etkinlik_takip/data/services/base_services/IFirebaseBaseService.dart';
import 'package:etkinlik_takip/product/functions/error_message_function.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends IFirebaseBaseService implements IAuthService {
  AuthService.init();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<BaseResponseModel<TokenModel>?> register({required String email, required String password}) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var idTokenResult = await response.user?.getIdTokenResult();
      var expirationTime = idTokenResult?.expirationTime;
      return BaseResponseModel(
        data: TokenModel(token: response.user?.uid, expiration: expirationTime),
      );
    } catch (e, stackTrace) {
      setError(exception: e, stackTrace: stackTrace);
      return BaseResponseModel(error: ErrorModel(errorMessage: e.toString()));
    }
  }

  @override
  Future<BaseResponseModel<TokenModel>?> login({required String email, required String password}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      var idTokenResult = await response.user?.getIdTokenResult();
      var expirationTime = idTokenResult?.expirationTime;
      return BaseResponseModel(
        data: TokenModel(token: response.user?.uid, expiration: expirationTime),
      );
    } catch (e, stackTrace) {
      String? errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage = ErrorMessageFunction().getFirebaseAuthErrorMessage(e.code);
      }
      errorMessage ??= 'Giriş Yapılamadı';
      setError(exception: e, stackTrace: stackTrace);
      return BaseResponseModel(error: ErrorModel(errorMessage: errorMessage));
    }
  }
}
