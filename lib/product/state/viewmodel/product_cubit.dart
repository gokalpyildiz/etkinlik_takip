import 'package:etkinlik_takip/product/state/base/base_cubit.dart';
import 'package:etkinlik_takip/product/state/viewmodel/product_state.dart';
import 'package:flutter/material.dart';

final class ProductCubit extends BaseCubit<ProductState> {
  ProductCubit() : super(const ProductState());

  /// Change theme mode
  /// [themeMode] is [ThemeMode.light] or [ThemeMode.dark]
  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }

  ThemeData get themeData => state.themeMode == ThemeMode.dark ? ThemeData.dark() : ThemeData.light();
}
