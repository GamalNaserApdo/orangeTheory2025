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
import 'package:otfksa2/ui/mian_tap_view/main_tab_viewmodel.dart'
    show MainTabViewModel;
import 'package:otfksa2/ui/setting/setting_view.dart';
import 'package:otfksa2/ui/setting/setting_view_model.dart';
import 'package:otfksa2/ui/subscription/subscriptions_viewmodel.dart';
import 'package:otfksa2/utils/app_routes.dart';
import 'package:otfksa2/ui/login/login_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainTabViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => MembersViewModel()),
        ChangeNotifierProvider(create: (_) => BookingsViewModel()),
        ChangeNotifierProvider(create: (_) => SubscriptionsViewModel()),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => PackagesViewModel()),
        ChangeNotifierProvider(create: (_) => StudiosViewModel()),
        ChangeNotifierProvider(create: (_) => CountriesCitiesViewModel()),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, settingsViewModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: _primaryColor,
              scaffoldBackgroundColor: const Color(0xFFF9F9F9),
              colorScheme: ColorScheme.light(
                primary: _primaryColor,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
              ),
              switchTheme: SwitchThemeData(
                thumbColor: MaterialStateProperty.all(_primaryColor),
                trackColor: MaterialStateProperty.all(_primaryColor.withOpacity(0.5)),
              ),
            ),
            darkTheme: ThemeData(
              primaryColor: _primaryColor,
              scaffoldBackgroundColor: Colors.black,
              colorScheme: ColorScheme.dark(
                primary: _primaryColor,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
              switchTheme: SwitchThemeData(
                thumbColor: MaterialStateProperty.all(_primaryColor),
                trackColor: MaterialStateProperty.all(_primaryColor.withOpacity(0.5)),
              ),
            ),
            themeMode: settingsViewModel.isDarkModeEnabled
                ? ThemeMode.dark
                : ThemeMode.light,
            routes: {
              AppRoutes.loginRouteName: (context) => const LoginView(),
              AppRoutes.dashboardRouteName: (context) => MainTabView(),
              AppRoutes.editPlanRouteName: (context) => EditPlanView(),
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
