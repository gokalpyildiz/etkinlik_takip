import 'package:etkinlik_takip/product/utility/my_string_utils.dart';

//todo string ifadeler merkezi olarak yönetilecek

final class ValidationsFunctions {
  static String? validateEmail(String? value) {
    if (value == null || value == '') {
      return 'Lütfen e-posta giriniz';
    } else if (value.isNotEmpty) {
      if (!MyStringUtils.isEmail(value)) {
        return 'Lütfen geçerli bir e-posta giriniz';
      }
    }
    return null;
  }

  static String? validateEmty(String? value) {
    if (value == null || value == '') {
      return 'Zorunlu alan';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value == '') {
      return 'Lütfen şifre giriniz';
    } else if (value.isNotEmpty) {
      if (value.isEmpty) {
        return 'Parola boş olamaz';
      } else if (value.length < 8) {
        return 'Şifreniz en az 8 karakter olmalıdır.';
      } else if (!value.contains(RegExp('[A-Z]'))) {
        return 'En az bir büyük harf içermelidir.';
      } else if (!value.contains(RegExp('[a-z]'))) {
        return 'En az bir küçük harf içermelidir.';
      }
      return null;
    }
    return null;
  }

  static String? validatePhone(String? value, {bool isRequired = true, int requiredPhoneLength = 10}) {
    final length = value!.length;
    if (!isRequired && value.isEmpty) {
      return null;
    }
    if (requiredPhoneLength != length) {
      return 'Telefon numarası 10 haneli olmalıdır';
    } else {
      return null;
    }
  }
}
