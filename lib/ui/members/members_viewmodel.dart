import 'package:flutter/material.dart';
import 'package:otfksa2/models/member_model.dart';
import 'package:otfksa2/ui/members/members_navigator.dart';
// import 'package:your_app/models/member_model.dart'; // استدعاء الموديل
// import 'members_navigator.dart';

class MembersViewModel extends ChangeNotifier {
  static const Color primaryColor = Color(0xFFF37B2D);

  List<Member> _allMembers = [];

  List<Member> _filteredMembers = [];
  List<Member> get filteredMembers => _filteredMembers;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  final TextEditingController searchController = TextEditingController();

  MembersViewModel() {
    fetchMembers();
    searchController.addListener(_filterMembers);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterMembers);
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchMembers() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // 
    _allMembers = [
      Member(
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+1 234 567 8900',
        status: MemberStatus.Active,
        plan: MembershipPlan.Premium,
        joinedDate: DateTime(2024, 1, 15),
      ),
      Member(
        id: '2',
        name: 'Sarah Smith',
        email: 'sarah@example.com',
        phone: '+1 234 567 8901',
        status: MemberStatus.Active,
        plan: MembershipPlan.Basic,
        joinedDate: DateTime(2024, 2, 20),
      ),
      Member(
        id: '3',
        name: 'Mike Johnson',
        email: 'mike@example.com',
        phone: '+1 234 567 8902',
        status: MemberStatus.Active,
        plan: MembershipPlan.Premium,
        joinedDate: DateTime(2024, 3, 10),
      ),
      Member(
        id: '4',
        name: 'Emma Wilson',
        email: 'emma@example.com',
        phone: '+1 234 567 8903',
        status: MemberStatus.Inactive,
        plan: MembershipPlan.Basic,
        joinedDate: DateTime(2023, 12, 5),
      ),
    ];
    _filteredMembers = _allMembers;
    _isLoading = false;
    notifyListeners();
  }

  void _filterMembers() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredMembers = _allMembers;
    } else {
      _filteredMembers = _allMembers.where((member) {
        return member.name.toLowerCase().contains(query) ||
            member.email.toLowerCase().contains(query);
      }).toList();
    }
    notifyListeners();
  }



  
  void onAddMemberPressed(BuildContext context) {
    MembersNavigator.goToAddMember(context);
  }

  void onViewMemberPressed(BuildContext context, Member member) {
    MembersNavigator.goToMemberDetails(context, member);
  }
}