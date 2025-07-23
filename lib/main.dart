import 'package:country_code_picker/country_code_picker.dart';
import 'package:etkinlik_takip/product/constants/app/language_constants.dart';
import 'package:etkinlik_takip/product/constants/ui/ui_constants.dart';
import 'package:etkinlik_takip/product/initialize/application_start.dart';
import 'package:etkinlik_takip/product/initialize/bloc_initialize.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_dark_theme.dart';
import 'package:etkinlik_takip/product/initialize/theme/custom_light_theme.dart';
import 'package:etkinlik_takip/product/state/container/product_state_items.dart';
import 'package:etkinlik_takip/product/state/viewmodel/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const BlocInitialize(child: MyApp()));
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: UiConstants.defaultSize,
      child: MaterialApp.router(
        routerConfig: ProductStateItems.appRouterHandler.config(),
        theme: CustomLightTheme().themeData,
        darkTheme: CustomDarkTheme().themeData,
        themeMode: context.watch<ProductCubit>().state.themeMode,
        debugShowCheckedModeBanner: false,
        supportedLocales: AppLanguages.supportedCountryPhoneItems,
        localizationsDelegates: [CountryLocalizations.delegate],
      ),
    );
  }
}
