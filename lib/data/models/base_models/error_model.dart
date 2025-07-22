// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String? propertyName;
  final String? errorMessage;
  final bool? tokenError;
  const ErrorModel({this.propertyName, this.errorMessage, this.tokenError});

  @override
  List<Object?> get props => [propertyName, errorMessage, tokenError];

  ErrorModel copyWith({String? propertyName, String? errorMessage, bool? tokenError}) {
    return ErrorModel(
      propertyName: propertyName ?? this.propertyName,
      errorMessage: errorMessage ?? this.errorMessage,
      tokenError: tokenError ?? this.tokenError,
    );
  }
}
