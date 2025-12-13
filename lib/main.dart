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
import 'package:otfksa2/ui/signup/signup_view.dart';
import 'package:otfksa2/ui/subscription/subscriptions_viewmodel.dart';
import 'package:otfksa2/utils/app_routes.dart';
import 'package:otfksa2/ui/login/login_view.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url:
        'https://pvdnhioqqdhpbwlgzjyc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB2ZG5oaW9xcWRocGJ3bGd6anljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ2MTUxOTQsImV4cCI6MjA4MDE5MTE5NH0.uB8BGFhrJigxSNKNBTY_8ZoxGc8O9B_PB67f61cCDbM', // انسخ المفتاح من إعدادات Supabase
  );
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
          AppRoutes.signupRouteName: (context) => const SignupView(),
          AppRoutes.dashboardRouteName: (context) => MainTabView(),
          AppRoutes.editPlanRouteName: (context) => EditPlanView(),
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
