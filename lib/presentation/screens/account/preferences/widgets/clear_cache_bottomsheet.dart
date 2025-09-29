import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lunari/core/style/app_theme.dart';
import 'package:lunari/core/utils/context_extention.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../blocs/preferences/preferences_bloc.dart';
import '../../../../blocs/preferences/preferences_event.dart';
import '../../../../blocs/preferences/preferences_state.dart';

class ClearCacheBottomsheet extends StatefulWidget {
  const ClearCacheBottomsheet({super.key});

  @override
  _ClearCacheBottomsheetState createState() => _ClearCacheBottomsheetState();
}

class _ClearCacheBottomsheetState extends State<ClearCacheBottomsheet> {
  bool _isClearing = false;

  Future<void> _clearCache(BuildContext context) async {
    setState(() => _isClearing = true);

    final bloc = context.read<PreferencesBloc>();
    final messenger = ScaffoldMessenger.of(context);

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }

      bloc.add(LoadPreferences());

      if (mounted) Navigator.pop(context);

      messenger.showSnackBar(
          SnackBar(
            content: Text('Cache cleared successfully'.tr()),
            backgroundColor: Colors.green,
          )
      );
    } catch (e) {
      if (mounted) {
        messenger.showSnackBar(
            SnackBar(
              content: Text('Error clearing cache: $e'.tr()),
              backgroundColor: Colors.red,
            )
        );
      }
    } finally {
      if (mounted) setState(() => _isClearing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferencesBloc, PreferencesState>(
      listener: (context, state) {
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(right: 24, left: 24, top: 15, bottom: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('clear_cache_?'.tr(),
                style: GoogleFonts.urbanist(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: context.colors.scrim,
                )),

            const SizedBox(height: 10),
            Text('remove_temporary_files'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 14.sp,
                  color: context.colors.scrim.withOpacity(0.7),
                )),

            const SizedBox(height: 20),
            Divider(
              thickness: 1,
              color: context.colors.dividerLight,
            ),
            const SizedBox(height: 20),

            // buttons:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _isClearing ? null : () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: context.colors.secondary,
                      ),
                      child: Text('cancel'.tr(),
                          style: GoogleFonts.urbanist(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: context.colors.primary,
                          )),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: _isClearing ? null : () => _clearCache(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: context.colors.primary,
                      ),
                      child: _isClearing
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : Text('ok'.tr(),
                          style: GoogleFonts.urbanist(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: context.colors.onPrimary,
                          )),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}