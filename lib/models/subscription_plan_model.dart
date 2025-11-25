// (ممكن تضعه في ملف منفصل: models/subscription_plan_model.dart)

class SubscriptionPlan {
  final String id;
  final String name;
  final String price;
  final String pricePeriod; // "/month"
  final String subscriberCount;
  final List<String> features;
  final bool isPopular;
  final bool isHighlighted; // (عشان الكارت البرتقالي)

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    this.pricePeriod = "/month",
    required this.subscriberCount,
    required this.features,
    this.isPopular = false,
    this.isHighlighted = false,
  });
}