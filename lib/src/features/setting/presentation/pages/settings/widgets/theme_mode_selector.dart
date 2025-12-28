import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_bloc.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_event.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state.status == ThemeStatus.loading && !state.isReady) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('settings.appearance.title'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tr('settings.appearance.subtitle'),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  SegmentedButton<AppThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: AppThemeMode.system,
                        label: Text(tr('settings.appearance.system')),
                        icon: const Icon(Icons.phone_android),
                      ),
                      ButtonSegment(
                        value: AppThemeMode.light,
                        label: Text(tr('settings.appearance.light')),
                        icon: const Icon(Icons.wb_sunny_outlined),
                      ),
                      ButtonSegment(
                        value: AppThemeMode.dark,
                        label: Text(tr('settings.appearance.dark')),
                        icon: const Icon(Icons.nightlight_round),
                      ),
                    ],
                    multiSelectionEnabled: false,
                    selected: <AppThemeMode>{state.mode},
                    onSelectionChanged: (selection) =>
                        _handleSelection(context, selection),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleSelection(BuildContext context, Set<AppThemeMode> selection) {
    if (selection.isEmpty) return;
    final mode = selection.first;
    context.read<ThemeBloc>().add(ThemeModeChanged(mode));
  }
}
