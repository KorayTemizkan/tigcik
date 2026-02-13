/*

Supabase storageden json içindeki daha önceki tüm yarışmalar çekilecek ve model listesiyle klasik liste oluşturulacak
Yapay Zeka'ya Sor bölümünün arayüzü gibi olucak. Burada üstte son yarışma bilgileri bulunacak
Yarışmanın:
Adı
tarih aralığı
yaptığını yerele yükle (not almak)
yaptığını toplulukla paylaş
ödüller: +100 tığcık, + 25.01.2025 ödülü

*/

import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/contest_provider.dart';
import 'package:knitting_app/controllers/widgets/content_card.dart';
import 'package:knitting_app/controllers/widgets/contest_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/controllers/widgets/vertical_card_list.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class ContestsView extends StatefulWidget {
  const ContestsView({super.key});

  @override
  State<ContestsView> createState() => _ContestsViewState();
}

class _ContestsViewState extends State<ContestsView> {
  @override
  Widget build(BuildContext context) {
    final contests = context.read<ContestProvider>().contests;

    return Scaffold(
      appBar: AppBarWidget(title: 'Yarışmalar'),
      body: ListView(
        children: [
          ContestCard(
            teacher: 'Fidan',
            name: 'Bebek Patiği',
            difficulty: 'Normal',
            header: '500 tığcık puanı ödüllü yarışma',
            content:
                'Yeni doğmuş bebeğinize gönül rahatlığıyla giydirebilirsiniz',
          ),


          TitleText(text: 'Önceki Yarışmalar'),
          
          /*
          GenericSearchAnchorBar<Searchable>(
            items: [...products, ...howTos],
            hintText: 'Ara...',
            onItemSelected: (item) {
              if (item is ProductModel) {
                context.go('/products', extra: item);
              } else if (item is HowToModel) {
                context.go('/howTo', extra: item);
              }
            },
          ),
          */

   
          VerticalCardList(
            itemCount: contests.length,
            cardHeight: 260, // yükseklik
            crossAxisCount: 2, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final contest = contests[index];

              return ContentCard(
                title: contest.title,
                difficulty: contest.difficulty,
                estimatedHour: contest.content,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
