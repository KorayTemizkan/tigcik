/*
Çalışma Akışı:

Model -> Provider -> View -> HorizontalCardList -> ContentCardList
*/

import 'package:flutter/material.dart';

class VerticalCardList extends StatelessWidget {
  final int itemCount; // kart adeti
  final double
  cardHeight; // kart yükseliği (eğer vermezsek vertical viewport was given unbounded height hatası alırız)
  final int crossAxisCount;
  final Widget Function(BuildContext, int)
  itemBuilder; // Sen bana index ver ben onu çizeyim

  const VerticalCardList({
    super.key,
    required this.itemCount,
    required this.cardHeight,
    this.crossAxisCount = 2,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    // yatay liste mutlaka bir yükseklik ister. Biz bunu ayarlıyoruz. SizedBox nedeni bu
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: cardHeight,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
