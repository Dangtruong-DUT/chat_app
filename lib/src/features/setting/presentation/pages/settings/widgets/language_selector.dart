import 'package:chat_app/src/core/i18n/app_locale.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  static const _locales = [Locale(AppLocale.en), Locale(AppLocale.vi)];

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final normalizedLocale = _locales.firstWhere(
      (locale) => locale.languageCode == currentLocale.languageCode,
      orElse: () => currentLocale,
    );

    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.only(top: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('settings.language.title'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                tr('settings.language.subtitle'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              SegmentedButton<Locale>(
                segments: _buildSegments(context),
                selected: {normalizedLocale},
                multiSelectionEnabled: false,
                onSelectionChanged: (selection) {
                  if (selection.isEmpty) return;
                  final locale = selection.first;
                  if (locale.languageCode == currentLocale.languageCode) {
                    return;
                  }
                  context.setLocale(locale);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<ButtonSegment<Locale>> _buildSegments(BuildContext context) {
    return _locales.map((locale) {
      final labelKey = locale.languageCode == AppLocale.en
          ? 'settings.language.en'
          : 'settings.language.vi';
      final icon = locale.languageCode == AppLocale.en
          ? Icons.language
          : Icons.translate;
      return ButtonSegment(
        value: locale,
        label: Text(tr(labelKey)),
        icon: Icon(icon),
      );
    }).toList();
  }
}
