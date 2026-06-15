import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grw_app/core/theme/grw_colors.dart';
import 'package:grw_app/core/theme/theme_mode_provider.dart';

Future<void> showMyAccountSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      final grw = sheetContext.grw;
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: grw.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: const SafeArea(
            top: false,
            child: _MyAccountSheetBody(),
          ),
        ),
      );
    },
  );
}

class _MyAccountSheetBody extends ConsumerWidget {
  const _MyAccountSheetBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grw = context.grw;
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: grw.borderLight,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: grw.avatarBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: GrwColors.primary, width: 2),
                ),
                child: Icon(Icons.person, color: grw.textSecondary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test Account',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: grw.textPrimary,
                      ),
                    ),
                    Text(
                      'maramnowaisser+statement@gmail.com',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: grw.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: grw.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: grw.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: grw.iconCircleBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    size: 20,
                    color: GrwColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: grw.textPrimary,
                        ),
                      ),
                      Text(
                        isDark ? 'On — dark theme active' : 'Off — light theme active',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: grw.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: isDark,
                  activeThumbColor: Colors.white,
                  activeTrackColor: grw.primaryAction,
                  onChanged: (value) {
                    ref.read(themeModeProvider.notifier).setDark(value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
