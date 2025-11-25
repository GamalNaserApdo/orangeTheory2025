import 'package:flutter/material.dart';
import 'package:otfksa2/ui/booking/bookings_view.dart';
import 'package:otfksa2/ui/dashboard/dashboard_view.dart';
import 'package:otfksa2/ui/drawer/app_drawer.dart';
import 'package:otfksa2/ui/members/members_view.dart';
import 'package:otfksa2/ui/subscription/subscriptions_view.dart';
import 'package:otfksa2/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
// ... (imports)
import 'main_tab_viewmodel.dart';

class MainTabView extends StatelessWidget {
  MainTabView({Key? key}) : super(key: key);

  final List<Widget> _pages = [
    DashboardView(),
    MembersView(),
    BookingsView(),
    SubscriptionsView(),
  ];


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MainTabViewModel>(context);

    return Scaffold(
      drawer: const AppDrawer(), 
      
      body: _pages[viewModel.currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.currentIndex,
        onTap: (index) => viewModel.onTabTapped(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Iconsax.people), label: 'Members'),
          BottomNavigationBarItem(icon: Icon(Iconsax.calendar_1), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Iconsax.card), label: 'Subscriptions'),
        ],
      ),
    );
  }
}