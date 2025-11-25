import 'package:flutter/material.dart';
import 'package:otfksa2/models/booking_model.dart';
// import 'package:your_app/models/booking_model.dart';
// import 'package:your_app/screens/add_booking/add_booking_view.dart';
// import 'package:your_app/screens/booking_details/booking_details_view.dart';
// import 'package:your_app/screens/dashboard/dashboard_view.dart';
// ...

class BookingsNavigator {
  
  static void goToAddBooking(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AddBookingView()),
    // );
    print("Navigator: Navigating to Add Booking...");
  }

  static void goToBookingDetails(BuildContext context, Booking booking) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => BookingDetailsView(bookingId: booking.id)),
    // );
    print("Navigator: Navigating to Details for ${booking.className}...");
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

  static void goToSubscriptions(BuildContext context) {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => SubscriptionsView()),
    // );
    print("Navigator: Navigating to Subscriptions...");
  }
}