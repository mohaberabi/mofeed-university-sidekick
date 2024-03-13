import 'package:flutter/cupertino.dart';

import '../../localization/app_local.dart';

extension LocalEasy on BuildContext {
  String get lang => AppLocalizations.of(this).locale;

  AppLocalizations get l10n => AppLocalizations.of(this);
}
