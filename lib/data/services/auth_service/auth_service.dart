import 'package:etkinlik_takip/data/models/auth_models/register_request_model.dart';
import 'package:etkinlik_takip/data/models/base_models/base_response_model.dart';
import 'package:etkinlik_takip/data/models/base_models/error_model.dart';
import 'package:etkinlik_takip/data/models/token/token_model.dart';
import 'package:etkinlik_takip/data/services/auth_service/IAuthService.dart';
import 'package:etkinlik_takip/data/services/base_services/IFirebaseBaseService.dart';
import 'package:etkinlik_takip/product/functions/error_message_function.dart';
import 'package:etkinlik_takip/product/utility/firebase/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService extends IFirebaseBaseService implements IAuthService {
  AuthService.init();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance;

  @override
  Future<BaseResponseModel<TokenModel>?> register({required RegisterRequestModel register}) async {
    try {
      if (register.email == null || register.password == null) {
        return BaseResponseModel(error: ErrorModel(errorMessage: 'Lütfen tüm alanları doldurunuz'));
      }
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: register.email!, password: register.password!);
      if (userCredential.user != null) {
        await _registerUser(
          userId: userCredential.user!.uid,
          name: register.name,
          email: register.email,
          password: register.password!,
          phone: register.phone,
          phoneCountryCode: register.phoneCountryCode,
        );
      }
      var idTokenResult = await userCredential.user?.getIdTokenResult();
      var expirationTime = idTokenResult?.expirationTime;
      return BaseResponseModel(
        data: TokenModel(token: userCredential.user?.uid, expiration: expirationTime),
      );
    } catch (e, stackTrace) {
      String? errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage = ErrorMessageFunction().getFirebaseErrorMessage(e.code);
      }
      errorMessage ??= 'Kayıt Yapılamadı';
      setError(exception: e, stackTrace: stackTrace);
      return BaseResponseModel(error: ErrorModel(errorMessage: errorMessage));
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
        errorMessage = ErrorMessageFunction().getFirebaseErrorMessage(e.code);
      }
      errorMessage ??= 'Giriş Yapılamadı';
      setError(exception: e, stackTrace: stackTrace);
      return BaseResponseModel(error: ErrorModel(errorMessage: errorMessage));
    }
  }

  Future<void> _registerUser({
    required String userId,
    required String? name,
    required String? email,
    required String password,
    String? phoneCountryCode,
    String? phone,
  }) async {
    try {
      await FirebaseCollections.users.reference.doc(userId).set({
        'email': email,
        'name': name,
        'password': password,
        'phone': phone,
        'phoneCountryCode': phoneCountryCode,
        'userId': userId,
        'registerDate': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      setError(exception: e.toString());
    }
  }
}
