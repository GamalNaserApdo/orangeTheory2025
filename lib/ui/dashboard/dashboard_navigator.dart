import 'package:flutter/cupertino.dart';

// import 'package:your_app/screens/members/members_view.dart';
// import 'package:your_app/screens/bookings/bookings_view.dart';
// ...

class DashboardNavigator {
  
  static void openDrawer(BuildContext context) {
    print("Navigator: Opening Drawer...");
  }

  static void goToMembers(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MembersView()),
    // );
    print("Navigator: Navigating to Members...");
  }

  static void goToBookings(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => BookingsView()),
    // );
    print("Navigator: Navigating to Bookings...");
  }

  static void goToSubscriptions(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SubscriptionsView()),
    // );
    print("Navigator: Navigating to Subscriptions...");
  }
}