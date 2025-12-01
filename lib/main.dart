import 'package:flutter/material.dart';
import 'package:otfksa2/ui/booking/bookings_viewmodel.dart';
import 'package:otfksa2/ui/dashboard/dashboard_viewmodel.dart';
import 'package:otfksa2/ui/drawer/country_cities_drawer/country_cities_view.dart';
import 'package:otfksa2/ui/drawer/country_cities_drawer/country_cities_view_model.dart';
import 'package:otfksa2/ui/drawer/packege_drawer/packege_view.dart';
import 'package:otfksa2/ui/drawer/packege_drawer/packege_view_model.dart';
import 'package:otfksa2/ui/drawer/studio_drawer/studio_view.dart';
import 'package:otfksa2/ui/drawer/studio_drawer/studio_view_model.dart';
import 'package:otfksa2/ui/editing_plan/edit_plan_view.dart';
import 'package:otfksa2/ui/members/members_viewmodel.dart';
import 'package:otfksa2/ui/mian_tap_view/main_tab_view.dart';
// import 'package:otfksa2/ui/mian_tap_view/main_tab_view.dart'; // <-- مبقاش هو البداية
import 'package:otfksa2/ui/mian_tap_view/main_tab_viewmodel.dart'
    show MainTabViewModel;
import 'package:otfksa2/ui/setting/setting_view.dart';
import 'package:otfksa2/ui/setting/setting_view_model.dart';
import 'package:otfksa2/ui/subscription/subscriptions_viewmodel.dart';
import 'package:otfksa2/utils/app_routes.dart';
import 'package:otfksa2/utils/app_them.dart';
import 'package:otfksa2/utils/theme_provider.dart';

// 1. --- (التعديل الأول) ---
// اعمل import لصفحة اللوجن
import 'package:otfksa2/ui/login/login_view.dart';
import 'package:provider/provider.dart'; // (أو المسار الصحيح بتاعها)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 4. استخدام MultiProvider لتوفير كل الـ ViewModels
    return MultiProvider(
      providers: [
        // ⭐️ ThemeProvider لإدارة الثيم
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        
        // الـ ViewModel الخاص بالـ Tabs
        ChangeNotifierProvider(create: (_) => MainTabViewModel()),

        // الـ ViewModels الخاصة بشاشات الـ BottomNavBar
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => MembersViewModel()),
        ChangeNotifierProvider(create: (_) => BookingsViewModel()),
        ChangeNotifierProvider(create: (_) => SubscriptionsViewModel()),

        // ⭐️ الـ ViewModels الجديدة (Settings + Business)
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => PackagesViewModel()),
        ChangeNotifierProvider(create: (_) => StudiosViewModel()),
        ChangeNotifierProvider(create: (_) => CountriesCitiesViewModel()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,

            routes: {
              AppRoutes.loginRouteName: (context) => const LoginView(),
              AppRoutes.dashboardRouteName: (context) => MainTabView(),
              AppRoutes.editPlanRouteName: (context) => EditPlanView(),
              // ⭐️ إضافة المسارات الجديدة
              AppRoutes.packagesRouteName: (context) => const PackagesView(),
              AppRoutes.studiosRouteName: (context) => const StudiosView(),
              AppRoutes.countriesCitiesRouteName: (context) =>
                  const CountriesCitiesView(),
              AppRoutes.settingsRouteName: (context) => const SettingView(),
            },

            home: const LoginView(),
          );
        },
      ),
    );
  }
}
