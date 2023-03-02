/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/delete_icon.png
  AssetGenImage get deleteIcon =>
      const AssetGenImage('assets/images/delete_icon.png');

  /// File path: assets/images/edit_icon.png
  AssetGenImage get editIcon =>
      const AssetGenImage('assets/images/edit_icon.png');

  /// File path: assets/images/email_icon.png
  AssetGenImage get emailIcon =>
      const AssetGenImage('assets/images/email_icon.png');

  /// File path: assets/images/email_icon2.png
  AssetGenImage get emailIcon2 =>
      const AssetGenImage('assets/images/email_icon2.png');

  /// File path: assets/images/empty_state.png
  AssetGenImage get emptyState =>
      const AssetGenImage('assets/images/empty_state.png');

  /// File path: assets/images/fav_icon.png
  AssetGenImage get favIcon =>
      const AssetGenImage('assets/images/fav_icon.png');

  /// File path: assets/images/profile_placeholder.png
  AssetGenImage get profilePlaceholder =>
      const AssetGenImage('assets/images/profile_placeholder.png');

  /// File path: assets/images/refresh_icon.png
  AssetGenImage get refreshIcon =>
      const AssetGenImage('assets/images/refresh_icon.png');

  /// File path: assets/images/send_icon.png
  AssetGenImage get sendIcon =>
      const AssetGenImage('assets/images/send_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        deleteIcon,
        editIcon,
        emailIcon,
        emailIcon2,
        emptyState,
        favIcon,
        profilePlaceholder,
        refreshIcon,
        sendIcon
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
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

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
