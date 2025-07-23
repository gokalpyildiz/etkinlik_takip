import 'package:flutter/material.dart';

class AssetsImagesGen {
  const AssetsImagesGen();

  /// File path: assets/images/img_flags.png
  AssetGenImage get imgWelcome => const AssetGenImage('assets/images/welcome.png');
  AssetGenImage get imgWelcomeTransparent => const AssetGenImage('assets/images/welcomeTransparent.png');

  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');
  AssetGenImage get logoTransparent => const AssetGenImage('assets/images/logoTransparent.png');
  AssetGenImage get imgSplash => const AssetGenImage('assets/images/splash.png');
  AssetGenImage get turkeyCircle => const AssetGenImage('assets/images/nations/turkey_circle.png');
  AssetGenImage get turkeySquare => const AssetGenImage('assets/images/nations/turkey_square.png');
  // AssetGenImage get googleContainer => const AssetGenImage('assets/images/google_container.png');
  // AssetGenImage get facebookContainer => const AssetGenImage('assets/images/facebook_container.png');
  // AssetGenImage get appleContainer => const AssetGenImage('assets/images/apple_container.png');
  AssetGenImage get splashBackGround => const AssetGenImage('assets/images/splash_background.png');
  AssetGenImage get appLogo => const AssetGenImage('assets/images/app_logo.png');
  AssetGenImage get visaLogo => const AssetGenImage('assets/images/credit_card_icons/visa.png');
  AssetGenImage get masterCardLogo => const AssetGenImage('assets/images/credit_card_icons/mastercard.png');
  AssetGenImage get americanExpressLogo => const AssetGenImage('assets/images/credit_card_icons/american_express.png');
  AssetGenImage get discoverLogo => const AssetGenImage('assets/images/credit_card_icons/discover.png');
  AssetGenImage get dinnersClubLogo => const AssetGenImage('assets/images/credit_card_icons/dinners_club.png');
  AssetGenImage get jcbLogo => const AssetGenImage('assets/images/credit_card_icons/jcb.png');
  AssetGenImage get verveLogo => const AssetGenImage('assets/images/credit_card_icons/verve.png');
  AssetGenImage get mapFinger => const AssetGenImage('assets/images/map-finger.png');
  AssetGenImage get car1 => const AssetGenImage('assets/images/car1.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    logo,
    imgWelcome,
    imgSplash,
    turkeySquare,
    turkeyCircle,
    // googleContainer,
    // facebookContainer,
    // appleContainer,
    splashBackGround,
    appLogo,
    mapFinger,
    car1,
  ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
