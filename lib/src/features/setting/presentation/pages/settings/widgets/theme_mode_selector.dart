import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_bloc.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_event.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_state.dart';
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

        return Card(
          margin: const EdgeInsets.only(top: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Switch between light, dark, or system-driven themes whenever you like.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                SegmentedButton<AppThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: AppThemeMode.system,
                      label: Text('System'),
                      icon: Icon(Icons.phone_android),
                    ),
                    ButtonSegment(
                      value: AppThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.wb_sunny_outlined),
                    ),
                    ButtonSegment(
                      value: AppThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.nightlight_round),
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
