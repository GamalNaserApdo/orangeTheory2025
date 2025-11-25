import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/models/member_model.dart';
// import 'package:otfksa/models/member_model.dart'; // <--- تأكد من استدعاء الموديل

class MemberDetailsDialog extends StatelessWidget {
  final Member member;
  const MemberDetailsDialog({Key? key, required this.member}) : super(key: key);

  static const Color _primaryColor = Color(0xFFF37B2D);
  static const Color _activeColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    final bool isActive = member.status == MemberStatus.Active;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Member Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. الاسم والحالة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  _StatusChip(isActive: isActive),
                ],
              ),
              const SizedBox(height: 15),

              // 2. تفاصيل الاتصال
              _DetailRow(
                icon: Iconsax.sms,
                label: 'Email',
                value: member.email,
              ),
              _DetailRow(
                icon: Iconsax.call,
                label: 'Phone',
                value: member.phone,
              ),
              const SizedBox(height: 15),

              const Divider(),
              const SizedBox(height: 15),

              // 3. تفاصيل الاشتراك
              _DetailRow(
                icon: Iconsax.crown,
                label: 'Plan',
                value: member.plan == MembershipPlan.Premium ? 'Premium' : 'Basic',
                color: member.plan == MembershipPlan.Premium ? _primaryColor : Colors.grey.shade700,
              ),
              _DetailRow(
                icon: Iconsax.calendar_add,
                label: 'Joined Date',
                value: member.joinedDate.toLocal().toString().split(' ')[0],
              ),
              
              // 4. زر للإجراء (اختياري: مثلاً تحرير)
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // هنا ممكن تستدعي navigator آخر للذهاب لشاشة تحرير العضو
                    Navigator.of(context).pop(); // إغلاق الـ Popup
                    // MembersNavigator.goToEditMemberScreen(context, member);
                  },
                  icon: const Icon(Iconsax.edit, size: 20),
                  label: const Text('Edit Member Profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================
// Helper Widgets
// ==================

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _DetailRow({required this.icon, required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color ?? Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// يمكن استخدام نفس الـ StatusChip اللي في MembersView
class _StatusChip extends StatelessWidget {
  final bool isActive;
  const _StatusChip({required this.isActive});
  
  // (نفس الكود الخاص بـ _StatusChip من ملف members_view.dart)
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Active' : 'Inactive',
        style: TextStyle(
          color: isActive ? Colors.green.shade800 : Colors.grey.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}