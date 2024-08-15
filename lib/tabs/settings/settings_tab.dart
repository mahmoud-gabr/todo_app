import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsetsDirectional.only(
              start: 25,
              top: 60,
            ),
            height: MediaQuery.of(context).size.height * .19,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Text(
              AppLocalizations.of(context)!.settings,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppTheme.white,
                    fontSize: 22,
                  ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: settingsProvider.isDark ? AppTheme.white : null,
                  ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppTheme.white,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                )),
            child: DropdownButton<String>(
              value: settingsProvider.language,
              isExpanded: true,
              underline: const SizedBox(),
              iconEnabledColor: Theme.of(context).primaryColor,
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(
                    'English',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'ar',
                  child: Text(
                    'العربية',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
              onChanged: (selectedLanguage) {
                if (selectedLanguage == null) return;
                settingsProvider.changLanguge(selectedLanguage);
              },
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Text(
              AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: settingsProvider.isDark ? AppTheme.white : null,
                  ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppTheme.white,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                )),
            child: DropdownButton<String>(
              value: settingsProvider.isDark ? 'dark' : 'light',
              isExpanded: true,
              underline: const SizedBox(),
              iconEnabledColor: Theme.of(context).primaryColor,
              items: [
                DropdownMenuItem(
                  value: 'light',
                  child: Text(
                    AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'dark',
                  child: Text(
                    AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
              onChanged: (mode) {
                if (mode == null) return;
                settingsProvider.changeTheme(
                    mode == 'light' ? ThemeMode.light : ThemeMode.dark);
              },
            ),
          ),
        ],
      ),
    );
  }
}
