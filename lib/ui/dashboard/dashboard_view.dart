import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/ui/dashboard/dashboard_viewmodel.dart';
import 'package:otfksa2/ui/widgtes/helper_widget.dart';
import 'package:provider/provider.dart';
// import 'dashboard_viewmodel.dart'; // اعمل import للملف اللي فوق
// import 'dashboard_navigator.dart'; // اعمل import للملف اللي هيجي

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DashboardViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // لون خلفية قريب من التصميم
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 150, 
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(
            'assets/images/orangetheory_logo.png',
          ), 
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.menu_1, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(),
              const SizedBox(height: 20),
              // total members , active booking , monthly revenue ,  growth rate
              buildStatsGrid(viewModel),
              const SizedBox(height: 24),
              // fl_chart
              buildRevenueOverview(context, viewModel),
              const SizedBox(height: 24),
              buildWeeklyBookings(context, viewModel),
              const SizedBox(height: 24),
              buildRecentActivity(viewModel),
            ],
          ),
        ),
      ),
    );
  }
}
 

  