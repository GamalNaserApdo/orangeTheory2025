import 'package:flutter/material.dart';

import 'package:otfksa2/models/subscription_plan_model.dart';
import 'package:otfksa2/ui/subscription/subscriptions_navigator.dart';
// import 'package:your_app/models/subscription_plan_model.dart';
// import 'subscriptions_navigator.dart';

class SubscriptionsViewModel extends ChangeNotifier {

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<SubscriptionPlan> _plans = [];
  List<SubscriptionPlan> get plans => _plans;

  SubscriptionsViewModel() {
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    _isLoading = true;
    notifyListeners();

    // ---- محاكاة جلب البيانات ----
    await Future.delayed(const Duration(milliseconds: 500));
    _plans = [
      SubscriptionPlan(
        id: 'basic',
        name: 'Basic',
        price: '\$29',
        subscriberCount: '234 subscribers',
        features: [
          'Access to gym equipment',
          'Locker room access',
          '2 group classes per month',
        ],
      ),
      SubscriptionPlan(
        id: 'premium',
        name: 'Premium',
        price: '\$49',
        subscriberCount: '567 subscribers',
        features: [
          'All Basic features',
          'Unlimited group classes',
          'Personal locker',
          'Free towel service',
        ],
        isPopular: true,
        isHighlighted: true, // (عشان الكارت البرتقالي)
      ),
      SubscriptionPlan(
        id: 'pro',
        name: 'Pro',
        price: '\$79',
        subscriberCount: '123 subscribers',
        features: [
          'All Premium features',
          '2 personal training sessions/month',
          'Nutrition consultation',
          'Priority booking',
          'Guest passes (2/month)',
        ],
      ),
    ];
    _isLoading = false;
    notifyListeners();
    // ---- نهاية المحاكاة ----
  }


  // -----  تم حذف دوال ومتغيرات الـ BottomNavBar من هنا -----


  // --- دوال الأزرار ---
  
  void onEditPlanPressed(BuildContext context, SubscriptionPlan plan) {
    SubscriptionsNavigator.goToEditPlan(context, plan);
  }
}