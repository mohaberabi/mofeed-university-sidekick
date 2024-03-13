import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mofeed_shared/ui/shapes/shapes.dart';

import '../colors/app_colors.dart';
import '../spacing/spacing.dart';
import '../typography/ui_text_style.dart';

class AppTheme {
  final String _locale;

  const AppTheme(String locale) : _locale = locale;

  Color get canvasColor => AppColors.primLight;

  Color get shadowColor => AppColors.lightGrey;

  Color get cardColor => Colors.white;

  ColorScheme get colorScheme {
    return ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primColor,
        onPrimary: Colors.white,
        secondary: AppColors.secondColor,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: backgroundColor,
        onBackground: Colors.black,
        surface: backgroundColor,
        onSurface: AppColors.primColor);
  }

  DialogTheme get dialogTheme {
    return const DialogTheme(
      backgroundColor: Colors.white,
      shadowColor: Colors.grey,
    );
  }

  ThemeData get themeData => ThemeData(
        dialogTheme: dialogTheme,
        useMaterial3: false,
        cardColor: cardColor,
        bottomNavigationBarTheme: bottomNavigationBarThemeData,
        textTheme: textTheme,
        shadowColor: shadowColor,
        cardTheme: cardTheme,
        scaffoldBackgroundColor: backgroundColor,
        dividerTheme: dividerTheme,
        appBarTheme: appBarTheme,
        snackBarTheme: snackBarTheme,
        iconTheme: iconTheme,
        textButtonTheme: textButtonTheme,
        dividerColor: dividerTheme.color,
        buttonTheme: buttonTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        bottomSheetTheme: bottomSheetTheme,
        listTileTheme: listTileTheme,
        switchTheme: switchTheme,
        colorScheme: colorScheme,
        progressIndicatorTheme: progressIndicatorTheme,
        tabBarTheme: tabBarTheme,
        backgroundColor: backgroundColor,
        canvasColor: canvasColor,
      );

  BottomNavigationBarThemeData get bottomNavigationBarThemeData =>
      BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primColor,
          unselectedLabelStyle:
              textTheme.bodyMedium!.copyWith(color: Colors.grey),
          selectedLabelStyle:
              textTheme.bodyMedium!.copyWith(color: AppColors.primColor),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: iconTheme,
          unselectedIconTheme: iconTheme.copyWith(color: Colors.grey));

  TextTheme get textTheme => _uiTextTheme;

  SnackBarThemeData get snackBarTheme {
    return SnackBarThemeData(
      contentTextStyle: _uiTextTheme.bodyLarge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      actionTextColor: AppColors.primMaterial.shade300,
      backgroundColor: Colors.black,
      elevation: 4,
      behavior: SnackBarBehavior.floating,
    );
  }

  TextTheme get _uiTextTheme => TextTheme(
        displayLarge: UiTextStyle.displayLarge,
        displayMedium: UiTextStyle.displayMedium,
        displaySmall: UiTextStyle.displaySmall,
        headlineLarge: UiTextStyle.headlineLarge,
        headlineMedium: UiTextStyle.headlineMedium,
        headlineSmall: UiTextStyle.headlineSmall,
        titleLarge: UiTextStyle.titleLarge,
        titleMedium: UiTextStyle.titleMedium,
        titleSmall: UiTextStyle.titleSmall,
        bodyLarge: UiTextStyle.bodyLarge,
        bodyMedium: UiTextStyle.bodyMedium,
        labelLarge: UiTextStyle.button,
        bodySmall: UiTextStyle.bodySmall,
        labelSmall: UiTextStyle.bodyMedium,
      ).apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
        decorationColor: Colors.black,
        fontFamily: _locale == 'ar'
            ? UiTextStyle.arabicFontName
            : UiTextStyle.englishFontName,
      );

  CardTheme get cardTheme {
    return CardTheme(color: Colors.white, shadowColor: shadowColor);
  }

  Color get backgroundColor => Colors.white;

  AppBarTheme get appBarTheme {
    return AppBarTheme(
      iconTheme: iconTheme.copyWith(color: Colors.black87),
      titleTextStyle: textTheme.headlineSmall!.copyWith(fontSize: 20),
      elevation: 0,
      toolbarHeight: 64,
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  IconThemeData get iconTheme {
    return const IconThemeData(color: Colors.black);
  }

  DividerThemeData get dividerTheme {
    return const DividerThemeData(
        color: AppColors.lightGrey, thickness: AppSpacing.xxxxs);
  }

  ButtonThemeData get buttonTheme {
    return ButtonThemeData(
      buttonColor: AppColors.primColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        textStyle: textTheme.labelLarge!.copyWith(color: Colors.white),
        backgroundColor: AppColors.primColor,
      ),
    );
  }

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

  BottomSheetThemeData get bottomSheetTheme {
    return BottomSheetThemeData(
      backgroundColor: backgroundColor,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.lg),
          topRight: Radius.circular(AppSpacing.lg),
        ),
      ),
    );
  }

  ListTileThemeData get listTileTheme {
    return const ListTileThemeData(
      iconColor: Colors.grey,
      contentPadding: EdgeInsets.all(AppSpacing.xs),
    );
  }

  SwitchThemeData get switchTheme {
    return SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.primColor;
        }
        return Colors.grey;
      }),
    );
  }

  ProgressIndicatorThemeData get progressIndicatorTheme {
    return const ProgressIndicatorThemeData(
      color: AppColors.primColor,
      circularTrackColor: AppColors.primDark,
    );
  }

  TabBarTheme get tabBarTheme {
    return TabBarTheme(
      labelStyle: textTheme.labelLarge,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      labelColor: AppColors.primColor,
      indicatorColor: AppColors.primColor,
      labelPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg, vertical: AppSpacing.md + AppSpacing.xxs),
      unselectedLabelStyle: textTheme.bodyLarge,
      unselectedLabelColor: Colors.black87,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: AppColors.primColor),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    );
  }
}
