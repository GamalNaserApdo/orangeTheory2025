import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// موديل بسيط عشان قايمة الأنشطة الأخيرة
class RecentActivity {
  final String name;
  final String action;
  final String timeAgo;

  RecentActivity({required this.name, required this.action, required this.timeAgo});
}

class DashboardViewModel extends ChangeNotifier {
  // هنا المفروض هتعمل Load للبيانات دي من الـ API أو الـ Repository
  // لكن حالياً هنحطها كبيانات ثابتة للتوضيح

  // بيانات الكروت العلوية
  String totalMembers = "1,234";
  String totalMembersChange = "+12.5%";
  String activeBookings = "456";
  String activeBookingsChange = "+8.2%";
  String monthlyRevenue = "\$45,678";
  String monthlyRevenueChange = "+15.3%";
  String growthRate = "23.1%";
  String growthRateChange = "+2.4%";

  // بيانات الرسم البياني (Revenue Overview)
  // دي مجرد بيانات وهمية
  final List<FlSpot> revenueSpots = const [
    FlSpot(0, 30000),
    FlSpot(1, 31000),
    FlSpot(2, 35000),
    FlSpot(3, 37000),
    FlSpot(4, 40000),
    FlSpot(5, 41000),
  ];

  final List<double> weeklyBookingsData = [45, 52, 48, 60, 55, 65, 42];


  final List<RecentActivity> recentActivities = [
    RecentActivity(name: "John Doe", action: "joined the gym", timeAgo: "2m ago"),
    RecentActivity(name: "Sarah Smith", action: "booked a class", timeAgo: "15m ago"),
    RecentActivity(name: "Mike Johnson", action: "renewed subscription", timeAgo: "1a ago"),
    RecentActivity(name: "Emma Wilson", action: "cancelled booking", timeAgo: "2a ago"),
  ];

  Future<void> fetchDashboardData() async {
    // ...
    // try {
    //   // final data = await _repository.getDashboardData();
    //   // ... حدث المتغيرات اللي فوق
    //   // notifyListeners(); // بلغ الـ View بالتغيير
    // } catch (e) {
    //   // ...
    // }
  }

  
}