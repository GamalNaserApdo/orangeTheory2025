import 'package:flutter/material.dart';
import 'package:otfksa2/models/subscription_plan_model.dart';
import 'package:otfksa2/utils/app_routes.dart';
// import 'package:your_app/models/subscription_plan_model.dart';
// import 'package:your_app/screens/edit_plan/edit_plan_view.dart';
// import 'package:your_app/screens/dashboard/dashboard_view.dart';
// ...

class SubscriptionsNavigator {
  
 static void goToEditPlan(BuildContext context, SubscriptionPlan plan) {
    // 1. استخدام التنقل المسمى (Named Route) لصفحة التعديل
    //    ونمرر معها مُعرّف الخطة (plan.id) كـ arguments
    Navigator.pushNamed(
      context,
      AppRoutes.editPlanRouteName, // افترضنا اسم المسار
      arguments: plan.id, // تمرير الـ ID ليتم جلبه في صفحة التعديل
    );
    
    print("Navigator: Navigating to Edit Plan ${plan.name} with ID: ${plan.id}");
  }
  // --- دوال الـ BottomNav ---
  
  static void goToDashboard(BuildContext context) {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => DashboardView()),
    // );
    print("Navigator: Navigating to Dashboard...");
  }

  static void goToMembers(BuildContext context) {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => MembersView()),
    // );
    print("Navigator: Navigating to Members...");
  }

  static void goToBookings(BuildContext context) {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => BookingsView()),
    // );
    print("Navigator: Navigating to Bookings...");
  }
}