import 'package:etkinlik_takip/data/models/base_models/error_model.dart';

class BaseResponseModel<T> {
  T? data;
  bool? success;
  String? message;
  ErrorModel? errors;
  BaseResponseModel({this.data, this.success, this.message, this.errors});
}
