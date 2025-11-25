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

// 1. --- (التعديل الأول) ---
// اعمل import لصفحة اللوجن
import 'package:otfksa2/ui/login/login_view.dart';
import 'package:provider/provider.dart'; // (أو المسار الصحيح بتاعها)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // تعريف اللون الأساسي
  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    // 4. استخدام MultiProvider لتوفير كل الـ ViewModels
    return MultiProvider(
      providers: [
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: _primaryColor,
          scaffoldBackgroundColor: const Color(0xFFF9F9F9),
          colorScheme: ColorScheme.fromSeed(
            seedColor: _primaryColor,
            primary: _primaryColor,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),

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
      ),
    );
  }
}
