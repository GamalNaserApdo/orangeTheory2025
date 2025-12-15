// privacy_policy_view.dart
import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        elevation: 0.5,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''
# Privacy Policy for Orange Theory Admin App

Last updated: December 15, 2025

Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.

## 1. Information We Collect
- Personal information (name, email) for account management.
- Usage data to improve app performance.
- Device information for troubleshooting.

## 2. How We Use Your Information
- To provide and maintain our service.
- To notify you about changes.
- To provide customer support.
- To monitor usage and improve the app.

## 3. Data Security
We implement security measures to protect your data, but no method is 100% secure.

## 4. Third-Party Services
We may use third-party services (e.g., Firebase, analytics) that collect data under their own privacy policies.

## 5. Changes to This Policy
We may update this policy. Continued use means acceptance of changes.

## Contact Us
If you have questions, contact us at: admin@orangetheory.com

Thank you for trusting us with your data.
          ''',
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}
