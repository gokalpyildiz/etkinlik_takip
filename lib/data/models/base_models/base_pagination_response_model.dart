import 'package:etkinlik_takip/data/models/base_models/error_model.dart';

class BasePaginationModel<T> {
  BasePaginationModel({this.data, this.totalItemCount, this.success, this.message, this.errors});
  List<T>? data;
  int? totalItemCount;
  bool? success;
  String? message;
  List<ErrorModel>? errors;
}
