import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:otfksa2/models/subscription_plan_model.dart';
import 'package:otfksa2/ui/subscription/subscriptions_viewmodel.dart';
import 'package:otfksa2/utils/app_colors.dart';
import 'package:provider/provider.dart';
// import 'package:your_app/models/subscription_plan_model.dart';
// import 'subscriptions_viewmodel.dart';
// import 'subscriptions_navigator.dart';

class SubscriptionsView extends StatelessWidget {
  const SubscriptionsView({Key? key}) : super(key: key);

  // اللون الأساسي

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SubscriptionsViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset('assets/images/orangetheory_logo.png'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.menu_1, color: Colors.black),
            onPressed: () {
              // ----- (التعديل هنا) -----
              // الكود ده بيدور على أقرب Scaffold (اللي هو في MainTabView)
              // وبيفتح الـ Drawer بتاعه
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              viewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : _buildPlansList(viewModel),
            ],
          ),
        ),
      ),
      // -----  تم حذف الـ BottomNavigationBar من هنا -----
    );
  }

  // ==================
  // Helper Widgets
  // ==================

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subscriptions',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Manage subscription plans',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPlansList(SubscriptionsViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.plans.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final plan = viewModel.plans[index];
        return _PlanCard(
          plan: plan,
          onEditPressed: () => viewModel.onEditPlanPressed(context, plan),
        );
      },
    );
  }
}

// ==================
// Widget مخصص لكارت الخطة
// ==================

class _PlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final VoidCallback onEditPressed;

  const _PlanCard({required this.plan, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: plan.isHighlighted
          ? _SubscriptionColors.highlightBg
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: plan.isHighlighted
              ? _SubscriptionColors.highlightBorder
              : Colors.transparent,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          plan.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (plan.isPopular) ...[
                          const SizedBox(width: 8),
                          _PopularChip(),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plan.subscriberCount,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    text: plan.price,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: plan.isHighlighted
                          ? _SubscriptionColors.highlightBorder
                          : _SubscriptionColors.proPrice,
                    ),
                    children: [
                      TextSpan(
                        text: plan.pricePeriod,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            ...plan.features.map((feature) => _FeatureItem(text: feature)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onEditPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: plan.isHighlighted
                    ? _SubscriptionColors.highlightBorder
                    : Colors.white,
                foregroundColor: plan.isHighlighted
                    ? Colors.white
                    : Colors.black,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: plan.isHighlighted
                        ? Colors.transparent
                        : Colors.grey.shade300,
                  ),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Edit Plan',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget لعلامة "Popular"
class _PopularChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _SubscriptionColors.highlightBorder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Popular',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

// Widget لسطر الميزة (علامة صح + النص)
class _FeatureItem extends StatelessWidget {
  final String text;
  const _FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            Iconsax.tick_circle,
            color: _SubscriptionColors.checkIcon,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// كلاس للألوان المستخدمة في التصميم
class _SubscriptionColors {
  static const Color highlightBorder = Color(0xFFF37B2D);
  static const Color highlightBg = Color(0xFFFFF8F3); // برتقالي فاتح جدا
  static const Color proPrice = Color(0xFF1E88E5); // أزرق (زي التصميم)
  static const Color checkIcon = Colors.blue; // أزرق (زي التصميم)
}
