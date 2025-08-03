import 'package:etkinlik_takip/data/models/base_models/error_model.dart';

class BaseResponseModel<T> {
  BaseResponseModel({this.data, required this.success, this.message, this.error});
  T? data;
  bool success;
  String? message;
  ErrorModel? error;
}
