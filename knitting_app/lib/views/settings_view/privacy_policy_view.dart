import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: 'Gizlilik Koşulları'),

      body: Column(
        children: [
          Text('Gizlilik Koşulları')
        ],
      ),
    );
  }
}