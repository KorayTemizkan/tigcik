import 'package:flutter/material.dart';

class BonusCard extends StatelessWidget {
  final String bonusType;
  final String bonus;
  const BonusCard({super.key, required this.bonusType, required this.bonus});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 16, left: 8,  right: 8),
      elevation: 0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
        side: const BorderSide(color: Color(0xFFFF5722), width: 1),
      ),

      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(color: Color(0xFFFF5722), Icons.card_giftcard),
                SizedBox(width: 10),
                Text(
                  bonusType,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(bonus),
                Icon(color: Color(0xFFFF5722), Icons.arrow_right),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
