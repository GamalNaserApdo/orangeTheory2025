import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/setting/setting_view_model.dart';
import 'package:provider/provider.dart';
import 'package:octo_image/octo_image.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingsViewModel>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(context, viewModel, isDark),
            const SizedBox(height: 24),
            _buildSettingsSection(
              title: 'General',
              children: [
                _SettingSwitchTile(
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme across the application.',
                  icon: Iconsax.sun_1,
                  value: viewModel.isDarkModeEnabled,
                  onChanged: viewModel.toggleDarkMode,
                  primaryColor: _primaryColor,
                ),
                _SettingSwitchTile(
                  title: 'Enable Notifications',
                  subtitle: 'Receive alerts for new bookings or changes.',
                  icon: Iconsax.notification,
                  value: viewModel.notificationsEnabled,
                  onChanged: viewModel.toggleNotifications,
                  primaryColor: _primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildSettingsSection(
              title: 'Account',
              children: [
                _SettingTapTile(
                  title: 'Change Password',
                  subtitle: 'Update your admin security password.',
                  icon: Iconsax.lock_1,
                  onTap: () {},
                  primaryColor: _primaryColor,
                ),
                _SettingTapTile(
                  title: 'Privacy Policy',
                  subtitle: 'Review application data handling policies.',
                  icon: Iconsax.security,
                  onTap: () {},
                  primaryColor: _primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context, SettingsViewModel viewModel, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _primaryColor,
            ),
          ),
        ),
        Card(
          color: isDark ? Colors.grey[900] : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _primaryColor, width: 2),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: viewModel.pickAndUploadImage,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: _primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Iconsax.camera,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin User',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'admin@orangetheory.com',
                        style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _primaryColor,
            ),
          ),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingSwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color primaryColor;

  const _SettingSwitchTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
      secondary: Icon(icon, color: primaryColor),
      value: value,
      onChanged: onChanged,
      activeColor: primaryColor,
    );
  }
}

class _SettingTapTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color primaryColor;

  const _SettingTapTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, color: isDark ? Colors.white : Colors.black),
      ),
      subtitle: Text(subtitle, style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey.shade600)),
      leading: Icon(icon, color: primaryColor),
      trailing: Icon(Icons.chevron_right, color: isDark ? Colors.white : Colors.grey),
      onTap: onTap,
    );
  }
}
