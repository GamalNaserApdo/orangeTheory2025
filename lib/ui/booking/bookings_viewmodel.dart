import 'package:flutter/material.dart';
import 'package:otfksa2/models/booking_model.dart';
import 'package:otfksa2/ui/booking/bookings_navigator.dart';
// import 'package:your_app/models/booking_model.dart';
// import 'bookings_navigator.dart';

class BookingsViewModel extends ChangeNotifier {
  // اللون الأساسي
  static const Color primaryColor = Color(0xFFF37B2D);

  // القائمة الأساسية (من الـ API)
  List<Booking> _allBookings = [];

  // القائمة اللي هتتعرض (بعد الفلترة)
  List<Booking> _filteredBookings = [];
  List<Booking> get filteredBookings => _filteredBookings;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final TextEditingController searchController = TextEditingController();

  // بيانات الإحصائيات
  String todayBookings = "24";
  String todayChange = "+3";
  String weekBookings = "156";
  String weekChange = "+12%";
  String cancelRate = "4.2%";
  String cancelChange = "-0.5%";


  BookingsViewModel() {
    fetchBookings();
    searchController.addListener(_filterBookings);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterBookings);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchBookings() async {
    _isLoading = true;
    notifyListeners();

    // ---- محاكاة جلب البيانات ----
    await Future.delayed(const Duration(seconds: 1));
    _allBookings = [
      Booking(
        id: 'b1',
        className: 'HIIT Training',
        memberName: 'John Doe',
        trainerName: 'Sarah Connor',
        bookingDate: DateTime(2024, 10, 28),
        bookingTime: '09:00 AM',
        status: BookingStatus.Confirmed,
      ),
      Booking(
        id: 'b2',
        className: 'Yoga Flow',
        memberName: 'Sarah Smith',
        trainerName: 'Mike Ross',
        bookingDate: DateTime(2024, 10, 28),
        bookingTime: '10:30 AM',
        status: BookingStatus.Confirmed,
      ),
      Booking(
        id: 'b3',
        className: 'Strength Training',
        memberName: 'Mike Johnson',
        trainerName: 'Emma Stone',
        bookingDate: DateTime(2024, 10, 28),
        bookingTime: '02:00 PM',
        status: BookingStatus.Pending,
      ),
    ];
    _filteredBookings = _allBookings;
    _isLoading = false;
    notifyListeners();
    // ---- نهاية المحاكاة ----
  }

  void _filterBookings() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredBookings = _allBookings;
    } else {
      _filteredBookings = _allBookings.where((booking) {
        return booking.className.toLowerCase().contains(query) ||
            booking.memberName.toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }

  // -----  تم حذف دوال ومتغيرات الـ BottomNavBar من هنا -----


  // --- دوال الأزرار ---
  
  void onAddBookingPressed(BuildContext context) {
    BookingsNavigator.goToAddBooking(context);
  }

  void onViewBookingPressed(BuildContext context, Booking booking) {
    BookingsNavigator.goToBookingDetails(context, booking);
  }
}