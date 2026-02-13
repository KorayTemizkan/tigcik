import 'package:flutter/material.dart';

class TitleWithSeeAll extends StatelessWidget {
  final String text;
  const TitleWithSeeAll({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Color(0xFFFF5722),
            ),
            child: Text(
              "Tümünü Gör",
              style: TextStyle(
                color: Color(0xFFFF5722),
                fontSize: 16,
                fontWeight: FontWeight.w900,
                
              ),
            ),
          ),
        ],
      ),
    );
  }
}
