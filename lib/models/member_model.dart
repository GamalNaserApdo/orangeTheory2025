// (ممكن تضعه في ملف منفصل: models/member_model.dart)

enum MemberStatus { Active, Inactive }
enum MembershipPlan { Premium, Basic }

class Member {
  final String id;
  final String name;
  final String email;
  final String phone;
  final MemberStatus status;
  final MembershipPlan plan;
  final DateTime joinedDate;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.plan,
    required this.joinedDate,
  });
}