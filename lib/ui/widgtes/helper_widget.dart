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
          ),
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
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSearchBar(MembersViewModel viewModel) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
      child: TextField(
        controller: viewModel.searchController,
        decoration: InputDecoration(
          icon: Icon(Iconsax.search_normal_1, color: Colors.grey[400]),
          hintText: 'Search members...',
          hintStyle: TextStyle(color: Colors.grey[400]),
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
      padding: const EdgeInsets.only(bottom: 20, top: 5),
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

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                _StatusChip(isActive: isActive),
              ],
            ),
            const SizedBox(height: 4),
            Text(member.email, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Iconsax.call, size: 16, color: Colors.grey[400]),
                const SizedBox(width: 8),
                Text(member.phone, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                const Spacer(),
                _PlanChip(isPremium: isPremium),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Joined: ${member.joinedDate.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
                InkWell(
                  onTap: onViewPressed,
                  child: const Row(
                    children: [
                      Text(
                        'View Details',
                        style: TextStyle(
                            color: MembersViewModel.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Iconsax.arrow_right_3, size: 16, color: MembersViewModel.primaryColor)
                    ],
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 3,
            backgroundColor: isActive ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 6),
          Text(
            isActive ? 'Active' : 'Inactive',
            style: TextStyle(
              color: isActive ? Colors.green[700] : Colors.grey[600],
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isPremium
            ? MembersViewModel.primaryColor.withOpacity(0.08)
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPremium
              ? MembersViewModel.primaryColor.withOpacity(0.2)
              : Colors.transparent,
        ),
      ),
      child: Text(
        isPremium ? 'Premium Plan' : 'Basic Plan',
        style: TextStyle(
          color: isPremium
              ? MembersViewModel.primaryColor
              : Colors.grey[600],
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}