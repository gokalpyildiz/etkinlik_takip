// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'package:etkinlik_takip/data/cache/hive/constants/hive_type_ids.dart';

part 'token_model.g.dart';

@HiveType(typeId: HiveTypeIds.tokenModel)
class TokenModel extends Equatable {
  const TokenModel({this.token, this.expiration, this.refreshToken, this.refreshTokenExpireDate, this.userId});

  @HiveField(0)
  final String? token;
  @HiveField(1)
  final DateTime? expiration;
  @HiveField(2)
  final String? refreshToken;
  @HiveField(3)
  final DateTime? refreshTokenExpireDate;
  @HiveField(4)
  final String? userId;

  @override
  List<Object?> get props => [token, expiration, refreshToken, refreshTokenExpireDate, userId];

  TokenModel copyWith({String? token, DateTime? expiration, String? refreshToken, DateTime? refreshTokenExpireDate, String? userId}) {
    return TokenModel(
      token: token ?? this.token,
      expiration: expiration ?? this.expiration,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenExpireDate: refreshTokenExpireDate ?? this.refreshTokenExpireDate,
      userId: userId ?? this.userId,
    );
  }
}
