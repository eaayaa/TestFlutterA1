import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _biometric = true;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSettingSection('Preferences'),
          _buildSwitchTile(
            Icons.dark_mode_outlined,
            'Dark Mode',
            'Switch to dark theme',
            _darkMode,
            (v) => setState(() => _darkMode = v),
          ),
          _buildLanguageTile(),
          const SizedBox(height: 32),
          _buildSettingSection('Notifications'),
          _buildSwitchTile(
            Icons.notifications_none_rounded,
            'Push Notifications',
            'Receive trip alerts',
            _notifications,
            (v) => setState(() => _notifications = v),
          ),
          const SizedBox(height: 32),
          _buildSettingSection('Security'),
          _buildSwitchTile(
            Icons.fingerprint_rounded,
            'Biometric Auth',
            'Use FaceID or Fingerprint',
            _biometric,
            (v) => setState(() => _biometric = v),
          ),
          ListTile(
            leading: const Icon(Icons.lock_outline_rounded, color: Colors.orange),
            title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {},
          ),
          const SizedBox(height: 32),
          _buildSettingSection('Privacy'),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined, color: Colors.orange),
            title: const Text('Privacy Policy', style: TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.orange),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      activeColor: Colors.orange,
      onChanged: onChanged,
    );
  }

  Widget _buildLanguageTile() {
    return ListTile(
      leading: const Icon(Icons.language_rounded, color: Colors.orange),
      title: const Text('Language', style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(_language, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {
        _showLanguagePicker();
      },
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _langItem('English'),
            _langItem('French'),
            _langItem('Spanish'),
            _langItem('German'),
          ],
        ),
      ),
    );
  }

  Widget _langItem(String lang) {
    return ListTile(
      title: Text(lang),
      trailing: _language == lang ? const Icon(Icons.check_circle, color: Colors.orange) : null,
      onTap: () {
        setState(() => _language = lang);
        Navigator.pop(context);
      },
    );
  }
}
