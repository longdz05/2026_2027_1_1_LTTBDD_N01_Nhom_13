import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import 'about_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: Text(s.t('settings_title'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(s.t('language'), style: Theme.of(context).textTheme.titleMedium),
          Card(
            child: RadioGroup<String>(
              groupValue: s.locale.languageCode,
              onChanged: (v) => s.setLanguage(v!),
              child: Column(
                children: [
                  RadioListTile<String>(
                    value: 'vi',
                    title: Text(s.t('lang_vi')),
                    secondary: const Text(
                      '🇻🇳',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  RadioListTile<String>(
                    value: 'en',
                    title: Text(s.t('lang_en')),
                    secondary: const Text(
                      '🇬🇧',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            s.t('appearance'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Card(
            child: SwitchListTile(
              title: Text(s.t('dark_mode')),
              subtitle: Text(s.t('dark_mode_sub')),
              secondary: const Icon(Icons.dark_mode),
              value: s.isDark,
              onChanged: s.setDark,
            ),
          ),
          const SizedBox(height: 20),
          Text(s.t('about'), style: Theme.of(context).textTheme.titleMedium),
          Card(
            child: ListTile(
              leading: const Icon(Icons.groups),
              title: Text(s.t('about_group')),
              subtitle: Text(s.t('about_group_sub')),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AboutScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
