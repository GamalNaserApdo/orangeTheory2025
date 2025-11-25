// (ممكن تضعه في ملف منفصل: models/booking_model.dart)

enum BookingStatus { Confirmed, Pending, Cancelled }

class Booking {
  final String id;
  final String className;
  final String memberName;
  final String trainerName;
  final DateTime bookingDate;
  final String bookingTime; // (String for simplicity)
  final BookingStatus status;

  Booking({
    required this.id,
    required this.className,
    required this.memberName,
    required this.trainerName,
    required this.bookingDate,
    required this.bookingTime,
    required this.status,
  });
}