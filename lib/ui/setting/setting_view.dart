import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/setting/setting_view_model.dart'; // تأكد من المسار
import 'package:otfksa2/utils/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:octo_image/octo_image.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    // ⭐️ نستخدم Provider.of مباشرة لأن ViewModel موفر في main.dart
    final viewModel = Provider.of<SettingsViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ⭐️ قسم البروفايل
            _buildProfileSection(context, viewModel),
            const SizedBox(height: 24),

            // قسم عام
            _buildSettingsSection(
              context,
              title: 'General',
              children: [
                _SettingSwitchTile(
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme across the application.',
                  icon: Iconsax.sun_1,
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(value),
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

            // قسم الحساب
            _buildSettingsSection(
              context,
              title: 'Account',
              children: [
                _SettingTapTile(
                  title: 'Change Password',
                  subtitle: 'Update your admin security password.',
                  icon: Iconsax.lock_1,
                  onTap: () {
                    // SettingsNavigator.goToChangePassword(context);
                  },
                  primaryColor: _primaryColor,
                ),
                _SettingTapTile(
                  title: 'Privacy Policy',
                  subtitle: 'Review application data handling policies.',
                  icon: Iconsax.security,
                  onTap: () {
                    // SettingsNavigator.goToPrivacyPolicy(context);
                  },
                  primaryColor: _primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ⭐️ Widget جديد لقسم البروفايل
  Widget _buildProfileSection(
    BuildContext context,
    SettingsViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
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
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // ⭐️ الصورة (لها حجم ثابت)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _primaryColor, width: 2),
                  ),
                  child: Stack(
                    children: [
                      // ClipOval(
                      //   child: OctoImage(
                      //     image: AssetImage(
                      //       viewModel.profileImageUrl,
                      //     ),
                      //     fit: BoxFit.cover,
                      //     progressIndicatorBuilder: (context, progress) =>
                      //         const Center(
                      //           child: CircularProgressIndicator(
                      //             color: _primaryColor,
                      //           ),
                      //         ),
                      //     errorBuilder: (context, error, stackTrace) =>
                      //         const Icon(
                      //           Iconsax.user_octagon,
                      //           size: 40,
                      //           color: Colors.grey,
                      //         ),
                      //     // ⭐️ الحل: نستخدم placeholderBuilder ونرجع Widget
                      //     placeholderBuilder: (context) =>
                      //         OctoPlaceholder.circleAvatar(
                      //           backgroundColor: Colors.grey.shade200,
                      //           text: Text(
                      //             'OT',
                      //             style: TextStyle(color: _primaryColor),
                      //           ),
                      //         )(context),
                      //   ),
                      // ),
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
                        ),
                        overflow: TextOverflow.ellipsis, // ✅ الحل الأول
                      ),
                      SizedBox(height: 4),
                      Text(
                        'admin@orangetheory.com',
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade400
                              : Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis, // ✅ الحل الثاني
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

  Widget _buildSettingsSection(
    BuildContext context, {
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
            side: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.grey.shade200,
            ),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

// ⭐️ Widget لـ ListTile فيه زرار Switch
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
      ),
      secondary: Icon(icon, color: primaryColor),
      value: value,
      onChanged: onChanged,
      activeColor: primaryColor,
    );
  }
}

// ⭐️ Widget لـ ListTile يمكن الضغط عليه
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
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
      ),
      leading: Icon(icon, color: primaryColor),
      trailing: Icon(
        Icons.chevron_right,
        color: isDark ? Colors.grey.shade400 : Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
