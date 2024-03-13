import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';
import 'package:mofeed_shared/ui/theme/theme.dart';

import '../colors/app_colors.dart';
import '../spacing/spacing.dart';
import '../typography/ui_text_style.dart';

class DarkTheme extends AppTheme {
  DarkTheme(String locale)
      : _locale = locale,
        super(locale);
  final String _locale;

  @override
  DividerThemeData get dividerTheme =>
      super.dividerTheme.copyWith(color: AppColors.lightGreyDark);

  TextTheme get _uiTextTheme => TextTheme(
        displayLarge: UiTextStyle.displayLarge,
        displayMedium: UiTextStyle.displayMedium,
        displaySmall: UiTextStyle.displaySmall,
        headlineMedium: UiTextStyle.headlineMedium,
        headlineSmall: UiTextStyle.headlineSmall,
        headlineLarge: UiTextStyle.headlineLarge,
        titleLarge: UiTextStyle.titleLarge,
        titleMedium: UiTextStyle.titleMedium,
        titleSmall: UiTextStyle.titleSmall,
        bodyLarge: UiTextStyle.bodyLarge,
        bodyMedium: UiTextStyle.bodyMedium,
        labelLarge: UiTextStyle.button,
        bodySmall: UiTextStyle.bodySmall,
        labelSmall: UiTextStyle.bodyMedium,
      ).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
        decorationColor: Colors.white,
        fontFamily: _locale == 'ar'
            ? UiTextStyle.arabicFontName
            : UiTextStyle.englishFontName,
      );

  @override
  TextTheme get textTheme => _uiTextTheme;

  @override
  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: AppColors.primColor,
        unselectedLabelStyle:
            textTheme.bodyMedium!.copyWith(color: Colors.grey),
        selectedLabelStyle:
            textTheme.bodyMedium!.copyWith(color: AppColors.primColor),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: iconTheme.copyWith(color: AppColors.primColor),
        unselectedIconTheme: iconTheme.copyWith(color: Colors.grey),
      );

  @override
  IconThemeData get iconTheme {
    return const IconThemeData(color: Colors.white);
  }

  @override
  ListTileThemeData get listTileTheme {
    return const ListTileThemeData(
      iconColor: Colors.white,
      contentPadding: EdgeInsets.all(AppSpacing.xs),
    );
  }

  @override
  TabBarTheme get tabBarTheme {
    return TabBarTheme(
      labelStyle: textTheme.labelLarge,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      labelColor: AppColors.primColor,
      indicatorColor: AppColors.primColor,
      labelPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.md + AppSpacing.xxs),
      unselectedLabelStyle: textTheme.bodyLarge,
      unselectedLabelColor: Colors.grey,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: AppColors.primColor),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  @override
  AppBarTheme get appBarTheme {
    return AppBarTheme(
      iconTheme: iconTheme.copyWith(color: Colors.white),
      titleTextStyle: textTheme.titleLarge,
      elevation: 0,
      toolbarHeight: 64,
      backgroundColor: backgroundColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  BottomSheetThemeData get bottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.darkBg,
      clipBehavior: Clip.hardEdge,
    );
  }

  @override
  TextButtonThemeData get textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        shadowColor: shadowColor,
        elevation: 0,
        side: BorderSide.none,
        disabledForegroundColor: AppColors.primMaterial.shade200,
        disabledIconColor: Colors.grey,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primColor,
        iconColor: AppColors.primColor,
        textStyle: textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primColor,
        ),
      ),
    );
  }

  @override
  Color get cardColor => AppColors.lightDark;

  @override
  Color get shadowColor => AppColors.lightGreyDark;

  @override
  CardTheme get cardTheme =>
      CardTheme(color: AppColors.lightDark, shadowColor: shadowColor);

  @override
  Color get canvasColor => AppColors.lightDark;

  @override
  DialogTheme get dialogTheme => DialogTheme(
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.withOpacity(0.7)),
          borderRadius: 16.circle));

  @override
  ColorScheme get colorScheme => ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primColor,
      onPrimary: Colors.white,
      secondary: AppColors.secondColor,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: backgroundColor,
      onBackground: Colors.white,
      surface: backgroundColor,
      onSurface: Colors.white);

  @override
  Color get backgroundColor => AppColors.darkBg;
}
