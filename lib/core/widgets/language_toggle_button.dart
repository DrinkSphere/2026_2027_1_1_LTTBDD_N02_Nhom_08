import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../localization/locale_controller.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.translate),
      tooltip: AppLocalizations.of(context)!.languageToggle,
      onPressed: localeController.toggle,
    );
  }
}
