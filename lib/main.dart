import 'package:country_code_picker/country_code_picker.dart';
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
        supportedLocales: const [
          Locale("af"),
          Locale("am"),
          Locale("ar"),
          Locale("az"),
          Locale("be"),
          Locale("bg"),
          Locale("bn"),
          Locale("bs"),
          Locale("ca"),
          Locale("cs"),
          Locale("da"),
          Locale("de"),
          Locale("el"),
          Locale("en"),
          Locale("es"),
          Locale("et"),
          Locale("fa"),
          Locale("fi"),
          Locale("fr"),
          Locale("gl"),
          Locale("ha"),
          Locale("he"),
          Locale("hi"),
          Locale("hr"),
          Locale("hu"),
          Locale("hy"),
          Locale("id"),
          Locale("is"),
          Locale("it"),
          Locale("ja"),
          Locale("ka"),
          Locale("kk"),
          Locale("km"),
          Locale("ko"),
          Locale("ku"),
          Locale("ky"),
          Locale("lt"),
          Locale("lv"),
          Locale("mk"),
          Locale("ml"),
          Locale("mn"),
          Locale("ms"),
          Locale("nb"),
          Locale("nl"),
          Locale("nn"),
          Locale("no"),
          Locale("pl"),
          Locale("ps"),
          Locale("pt"),
          Locale("ro"),
          Locale("ru"),
          Locale("sd"),
          Locale("sk"),
          Locale("sl"),
          Locale("so"),
          Locale("sq"),
          Locale("sr"),
          Locale("sv"),
          Locale("ta"),
          Locale("tg"),
          Locale("th"),
          Locale("tk"),
          Locale("tr"),
          Locale("tt"),
          Locale("uk"),
          Locale("ug"),
          Locale("ur"),
          Locale("uz"),
          Locale("vi"),
          Locale("zh"),
        ],
        localizationsDelegates: [CountryLocalizations.delegate],
      ),
    );
  }
}
