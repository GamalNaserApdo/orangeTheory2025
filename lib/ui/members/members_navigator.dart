import 'package:flutter/material.dart';
import 'package:otfksa2/models/member_model.dart';
import 'package:otfksa2/ui/members/MemberDetailsDialog.dart';
// import 'package:your_app/models/member_model.dart';
// import 'package:your_app/screens/add_member/add_member_view.dart';
// import 'package:your_app/screens/member_details/member_details_view.dart';
// import 'package:your_app/screens/dashboard/dashboard_view.dart';
// ...

class MembersNavigator {
  static void goToAddMember(BuildContext context) {
    print("Navigator: Navigating to Add Member...");
  }

  static void goToMemberDetails(BuildContext context, Member member) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // نستخدم الـ Widget الجديد لعرض التفاصيل
        return MemberDetailsDialog(member: member);
      },
    );
    print("Navigator: Showing details dialog for ${member.name}...");
  }
}

void goToDashboard(BuildContext context) {
  // استخدام pushReplacement عشان ميحصلش تراكم للصفحات
  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (context) => DashboardView()),
  // );
  print("Navigator: Navigating to Dashboard...");
}

void goToBookings(BuildContext context) {
  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (context) => BookingsView()),
  // );
  print("Navigator: Navigating to Bookings...");
}

void goToSubscriptions(BuildContext context) {
  // Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(builder: (context) => SubscriptionsView()),
  // );
  print("Navigator: Navigating to Subscriptions...");
}
