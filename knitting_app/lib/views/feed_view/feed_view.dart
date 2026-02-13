import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/providers/auth_provider.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/controllers/widgets/bonus_card.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/comment_section.dart';
import 'package:knitting_app/controllers/widgets/content_card.dart';
import 'package:knitting_app/controllers/widgets/contest_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/info_card.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/controllers/widgets/title_with_icon.dart';
import 'package:knitting_app/controllers/widgets/title_with_see_all.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:knitting_app/controllers/app_bar.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final knittingCafes = context.watch<KnittingCafeProvider>().knittingCafes;
    //final auth = context.watch<AuthProviderFirebase>();
    final sp = context.read<SharedPreferencesProvider>();

    return Scaffold(
      appBar: AppBarWidget(title: 'Ana Sayfa'),

      body: ListView(
        children: [
          Card(
            // margin: En dışta yatay ve dikey ne kadar boşluk olacağını ayarlar
            margin: EdgeInsets.only(top: 8, left: 16, right: 16),
            // elevation: Kartın altındaki gölge miktarını ayarlar.
            elevation: 0,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
              side: const BorderSide(color: Color(0xFFFF5722), width: 1),
            ),

            child: Padding(
              // padding: Kartın içinde yatay ve dikey ne kadar boşluk olacağını ayarlar.
              padding: const EdgeInsets.all(24.0),

              child: Column(
                // Elemanlar nereye yatık dizilecek
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Merhaba Koray :)",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF5722),
                    ),
                  ),

                  // Elemanlar arası boşluğu ayarlar
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      // Sol taraftaki profil fotoğrafı ayarları
                      const CircleAvatar(
                        // Çap büyüklüğü
                        radius: 24,
                        backgroundColor: Colors.grey,
                      ),

                      // Elemanlar arası boşluğu ayarlar
                      const SizedBox(width: 16),

                      // Orta kısımdaki altı çizili metin
                      const Expanded(
                        child: Text(
                          "Bugün hava patik örmek için çok güzel gözüküyor :)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Sağ alt köşedeki ok ikonu
                      Icon(Icons.arrow_forward, color: Color(0xFFFF5722)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          TitleText(text: 'Bonus Köşesi'),

          // Haftalık İlerleme Kartı Tasarımı
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 16),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Color(0xFFFF5722), width: 1),
            ),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const TitleWithIcon(
                    title: "Haftalık Bonus Yolculuğu",
                    icon: Icons.auto_awesome_motion_rounded,
                  ),

                  const SizedBox(height: 12),

                  // 7 Günlük İlerleme Çizgisi (GEMİNİ YAPTI ÖZÜR DİLERİM)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      bool isCompleted =
                          index < 3; // Örnek: ilk 3 gün tamamlanmış
                      return Column(
                        children: [
                          Icon(
                            isCompleted
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: isCompleted
                                ? const Color(0xFFFF5722)
                                : Colors.grey,
                            size: 24,
                          ),
                          Text(
                            "${index + 1}. Gün",
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      );
                    }),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "4 gün daha gel, Sürpriz Tarif'in kilidini aç!",
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),

          /*
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              BonusCard(bonusType: 'Günlük b', bonus: '240 tığcık'),
              BonusCard(bonusType: 'Çark Çevir', bonus: 'Kalan Hak (0/2)'),
            ],
          ),
          */

          HorizontalCardList(
            itemCount: products.length,
            height: 160, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              return BonusCard(bonusType: 'Günlük Bonus', bonus: '240 Tığcık');
            },
          ),

          TitleWithSeeAll(text: 'Yeni Eklenenler'),

          HorizontalCardList(
            itemCount: products.length,
            height: 240, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {
                  context.go('/product', extra: product);
                },
              );
            },
          ),

          TitleWithSeeAll(text: 'Bilgi Köşesi'),

          HorizontalCardList(
            itemCount: products.length,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {},
              );
            },
          ),

          TitleWithSeeAll(text: 'Haftanın Favorileri'),

          HorizontalCardList(
            itemCount: products.length,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final product = products[index];

              return ContentCard(
                title: product.title,
                difficulty: product.difficulty,
                estimatedHour: product.estimatedHour,
                onTap: () {},
              );
            },
          ),

          TitleText(text: 'Haftanın Yarışması'),

          ContestCard(
            teacher: 'Fidan',
            name: 'Bebek Patiği',
            difficulty: 'Normal',
            header: '500 tığcık puanı ödüllü yarışma',
            content:
                'YEni doğmuş bebeğinize gönül rahatlığıyla giydirebilirsiniz',
          ),

          TitleText(text: 'Biz Kimiz?'),

          CardList(
            widgets: [
              InfoCard(
                icon: Icon(Icons.abc_outlined, color: Color(0xFFFF5722)),
                text: 'Biz kimiz? :)',
              ),
            ],
          ),

          SizedBox(height: 15),
        ],
      ),
    );
  }
}
