import 'package:flutter/material.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final bodyStyle = theme.textTheme.bodyLarge;
    final labelStyle = bodyStyle?.copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aboutTitle),
        centerTitle: true,
        actions: const [LanguageToggleButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: Icon(
                  Icons.local_drink,
                  size: 72,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  l10n.appName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Text(l10n.subjectLabel, style: labelStyle),
              Text(l10n.subjectValue, style: bodyStyle),

              const SizedBox(height: 16),
              Text(l10n.lecturerLabel, style: labelStyle),
              Text(l10n.lecturerValue, style: bodyStyle),

              const SizedBox(height: 16),
              Text(l10n.groupLabel, style: labelStyle),
              Text(l10n.groupValue, style: bodyStyle),

              const SizedBox(height: 16),
              Text(l10n.membersLabel, style: labelStyle),
              Text(l10n.membersValue, style: bodyStyle),
            ],
          ),
        ),
      ),
    );
  }
}
