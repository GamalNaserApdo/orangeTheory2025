import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/drawer/app_drawer_navigator.dart';
import 'package:provider/provider.dart';
import 'package:otfksa2/ui/mian_tap_view/main_tab_viewmodel.dart'; // (المسار بتاعك)

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  // اللون الأساسي

  @override
  Widget build(BuildContext context) {
    // بنجيب الـ ViewModel بتاع الـ Tabs عشان نعرف الـ index الحالي
    final tabViewModel = Provider.of<MainTabViewModel>(context);
    final int currentIndex = tabViewModel.currentIndex;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 1. الهيدر (اللوجو)
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/images/orangetheory_logo.png', // (لازم تكون ضفت اللوجو)
                height: 35,
              ),
            ),
          ),

          // 2. الأزرار الأساسية (بتقرأ من الـ TabViewModel)
          _DrawerItem(
            title: 'Dashboard',
            icon: Iconsax.home,
            isSelected: currentIndex == 0,
            onTap: () {
              Navigator.pop(context); // اقفل الـ Drawer
              tabViewModel.onTabTapped(0); // غير الـ Tab
            },
          ),
          _DrawerItem(
            title: 'Members',
            icon: Iconsax.people,
            isSelected: currentIndex == 1,
            onTap: () {
              Navigator.pop(context);
              tabViewModel.onTabTapped(1);
            },
          ),
          _DrawerItem(
            title: 'Bookings',
            icon: Iconsax.calendar_1,
            isSelected: currentIndex == 2,
            onTap: () {
              Navigator.pop(context);
              tabViewModel.onTabTapped(2);
            },
          ),
          _DrawerItem(
            title: 'Subscriptions',
            icon: Iconsax.card,
            isSelected: currentIndex == 3,
            onTap: () {
              Navigator.pop(context);
              tabViewModel.onTabTapped(3);
            },
          ),

          // 3. فاصل
          const Divider(
            color: Colors.black12,
            height: 20,
            indent: 16,
            endIndent: 16,
          ),
          // AppDrawer.dart (داخل ListView)

          // ... (بعد زرار Subscriptions)

          // ⭐️ قسم Business الجديد
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 10, bottom: 5),
            child: Text(
              'Business',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),

          _DrawerItem(
            title: 'Packages',
            icon: Iconsax.box,
            isSelected: false,
            onTap: () => AppDrawerNavigator.goToPackages(context),
          ),
          _DrawerItem(
            title: 'Studios',
            icon: Iconsax.building,
            isSelected: false,
            onTap: () => AppDrawerNavigator.goToStudios(context),
          ),
          _DrawerItem(
            title: 'Countries & Cities',
            icon: Iconsax.global,
            isSelected: false,
            onTap: () => AppDrawerNavigator.goToCountriesCities(context),
          ),

          const Divider(
            color: Colors.black12,
            height: 20,
            indent: 16,
            endIndent: 16,
          ),

          // ... (باقي الأزرار: Settings و Logout)
          // 4. زرار الإعدادات (بيكلم الـ AppDrawerNavigator)
          _DrawerItem(
            title: 'Settings',
            icon: Iconsax.setting_2,
            isSelected: false, // (لأنها شاشة منفصلة)
            onTap: () => AppDrawerNavigator.goToSettings(context),
          ),

          // 5. زرار تسجيل الخروج (بيكلم الـ AppDrawerNavigator)
          _DrawerItem(
            title: 'Logout',
            icon: Iconsax.logout,
            isSelected: false,
            isLogout: true, // (عشان نديله لون أحمر)
            onTap: () => AppDrawerNavigator.doLogout(context),
          ),
        ],
      ),
    );
  }
}

// ==================
// Helper Widget (عشان شكل الزرار)
// ==================
class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLogout;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.isLogout = false,
  });

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    // تحديد اللون (أحمر لو خروج، برتقالي لو مختار، رمادي لو عادي)
    final Color color = isLogout
        ? Colors.red
        : (isSelected ? _primaryColor : Colors.grey[700]!);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? _primaryColor.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? _primaryColor : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: color, size: 22),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 15,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
