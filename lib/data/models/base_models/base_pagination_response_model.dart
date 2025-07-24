import 'package:etkinlik_takip/data/models/base_models/error_model.dart';

class BasePaginationModel<T> {
  BasePaginationModel({this.data, this.totalItemCount, required this.success, this.message, this.error});
  List<T>? data;
  int? totalItemCount;
  bool success;
  String? message;
  ErrorModel? error;
}
