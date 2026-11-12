import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsProvider>();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(s.t('about_title'))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundColor: scheme.primary,
                  child: Icon(Icons.style, size: 52, color: scheme.onPrimary),
                ),
                const SizedBox(height: 12),
                Text(
                  'WordFlip',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(s.t('app_desc'), textAlign: TextAlign.center),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                _InfoTile(
                  icon: Icons.school,
                  title: s.t('course'),
                  value: s.t('course_name'),
                ),
                const Divider(height: 1),
                _InfoTile(
                  icon: Icons.groups,
                  title: s.t('group'),
                  value: 'N01 - Nhóm 13',
                ),
                const Divider(height: 1),
                _InfoTile(
                  icon: Icons.cast_for_education,
                  title: s.t('teacher'),
                  value: 'que.nguyenxuan@phenikaa-uni.edu.vn',
                ),
                const Divider(height: 1),
                _InfoTile(
                  icon: Icons.code,
                  title: s.t('tech'),
                  value: 'Flutter, Dart, Provider',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(s.t('member'), style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          const _MemberCard(name: 'Vũ Thành Long', studentId: '23010882'),
          const SizedBox(height: 12),
          const _MemberCard(name: 'Phạm Hồng Sơn', studentId: '23010883'),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final String name;
  final String studentId;

  const _MemberCard({required this.name, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsProvider>();
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Text(
            name.split(' ').last[0],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: scheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Text(name),
        subtitle: Text('${s.t('student_id')}: $studentId'),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
