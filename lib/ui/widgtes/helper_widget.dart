import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/models/member_model.dart';
import 'package:otfksa2/ui/dashboard/dashboard_viewmodel.dart';
import 'package:otfksa2/ui/members/members_viewmodel.dart';
import 'package:otfksa2/utils/app_colors.dart';

class _ChartContainer extends StatelessWidget {
  final String title;
  final Widget child;
  const _ChartContainer({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            SizedBox(height: 150, child: child),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title, value, change;
  final IconData icon;
  final Color iconColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              change,
              style: const TextStyle(color: Colors.green, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildRecentActivity(DashboardViewModel viewModel) {
  return _ChartContainer(
    // استخدام نفس الكارت
    title: 'Recent Activity',
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.recentActivities.length,
      itemBuilder: (context, index) {
        final activity = viewModel.recentActivities[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            activity.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            activity.action,
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Text(
            activity.timeAgo,
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    ),
  );
}

Widget buildWeeklyBookings(BuildContext context, DashboardViewModel viewModel) {
  return _ChartContainer(
    title: 'Weekly Bookings',
    child: BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ), // يمكنك إضافة أيام الأسبوع هنا
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: viewModel.weeklyBookingsData
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: value,
                      color: AppColors.primaryColor,
                      width: 20,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                  ],
                ),
              ),
            )
            .values
            .toList(),
      ),
    ),
  );
}

Widget buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Dashboard',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Text(
        'Welcome back! Here’s your gym overview.',
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    ],
  );
}

Widget buildStatsGrid(DashboardViewModel viewModel) {
  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.7,
    children: [
      _StatCard(
        title: 'Total Members',
        value: viewModel.totalMembers,
        change: viewModel.totalMembersChange,
        icon: Iconsax.people,
        iconColor: Colors.blue,
      ),
      _StatCard(
        title: 'Active Bookings',
        value: viewModel.activeBookings,
        change: viewModel.activeBookingsChange,
        icon: Iconsax.calendar_tick,
        iconColor: Colors.green,
      ),
      _StatCard(
        title: 'Monthly Revenue',
        value: viewModel.monthlyRevenue,
        change: viewModel.monthlyRevenueChange,
        icon: Iconsax.dollar_square,
        iconColor: AppColors.primaryColor,
      ),
      _StatCard(
        title: 'Growth Rate',
        value: viewModel.growthRate,
        change: viewModel.growthRateChange,
        icon: Iconsax.trend_up,
        iconColor: Colors.purple,
      ),
    ],
  );
}

Widget buildRevenueOverview(
  BuildContext context,
  DashboardViewModel viewModel,
) {
  return _ChartContainer(
    title: 'Revenue Overview',
    child: LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: viewModel.revenueSpots,
            isCurved: true,
            color: AppColors.primaryColor,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primaryColor.withValues(alpha: 0.1),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSearchBar(MembersViewModel viewModel) {
  return Card(
    elevation: 0,
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: viewModel.searchController,
        decoration: const InputDecoration(
          icon: Icon(Iconsax.search_normal_1, color: Colors.grey),
          hintText: 'Search members...',
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Widget buildMembersList(MembersViewModel viewModel) {
  if (viewModel.filteredMembers.isEmpty) {
    return const Expanded(child: Center(child: Text('No members found.')));
  }

  return Expanded(
    child: ListView.builder(
      itemCount: viewModel.filteredMembers.length,
      itemBuilder: (context, index) {
        final member = viewModel.filteredMembers[index];
        return _MemberCard(
          member: member,
          onViewPressed: () => viewModel.onViewMemberPressed(context, member),
        );
      },
    ),
  );
}

class _MemberCard extends StatelessWidget {
  final Member member;
  final VoidCallback onViewPressed;

  const _MemberCard({required this.member, required this.onViewPressed});

  @override
  Widget build(BuildContext context) {
    final bool isActive = member.status == MemberStatus.Active;
    final bool isPremium = member.plan == MembershipPlan.Premium;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  member.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _StatusChip(isActive: isActive),
              ],
            ),
            Text(member.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(member.phone, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 12),
                _PlanChip(isPremium: isPremium),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Joined: ${member.joinedDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                TextButton(
                  onPressed: onViewPressed,
                  child: const Text(
                    'View',
                    style: TextStyle(color: MembersViewModel.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final bool isActive;
  const _StatusChip({required this.isActive});

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

class _PlanChip extends StatelessWidget {
  final bool isPremium;
  const _PlanChip({required this.isPremium});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPremium
            ? MembersViewModel.primaryColor.withValues(alpha: 0.1)
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isPremium
              ? MembersViewModel.primaryColor
              : Colors.grey.shade400,
        ),
      ),
      child: Text(
        isPremium ? 'Premium' : 'Basic',
        style: TextStyle(
          color: isPremium
              ? MembersViewModel.primaryColor
              : Colors.grey.shade700,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
