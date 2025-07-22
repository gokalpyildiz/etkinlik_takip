final class ErrorMessageFunction {
  ErrorMessageFunction._();
  static ErrorMessageFunction? _instance;
  factory ErrorMessageFunction() {
    return _instance ?? (_instance = ErrorMessageFunction._());
  }
  String getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'invalid-email':
        return 'Geçersiz e-posta adresi.';
      case 'user-disabled':
        return 'Bu hesap devre dışı bırakılmış.';
      case 'user-not-found':
        return 'Bu e-posta ile kayıtlı bir kullanıcı bulunamadı.';
      case 'wrong-password':
        return 'Hatalı şifre girdiniz.';
      case 'email-already-in-use':
        return 'Bu e-posta zaten kullanılıyor.';
      case 'weak-password':
        return 'Parolanız çok zayıf.';
      case 'operation-not-allowed':
        return 'Bu işlem şu anda aktif değil.';
      default:
        return 'Bilinmeyen bir hata oluştu. Kod: $code';
    }
  }
}
