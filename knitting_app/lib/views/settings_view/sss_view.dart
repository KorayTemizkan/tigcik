// SUPABASE'DEN YERELE ÇEKİLECEK AMA SONRA YAPARIZ

import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/url_launcher_controller.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/info_card.dart';
import 'package:knitting_app/controllers/widgets/my_gesture_button.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';

class SssView extends StatefulWidget {
  const SssView({super.key});

  @override
  State<SssView> createState() => _SssViewState();
}

class _SssViewState extends State<SssView> {
  Future<void> _showMyDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Merhaba'),
          content: Text(
            'WhatsApp hattımıza yönlendiriliyorsunuz! Soru, öneri ve şikayetlerinizi bizlere iletebilirsiniz',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Geri dön'),
            ),
            TextButton(
              onPressed: () => openWhatsAppSupport(),
              child: const Text('Devam et'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Rehber'),

      body: ListView(
        children: [
          SizedBox(height: 15),

          TitleText(text: 'Başlarken'),
          CardList(
            widgets: [
              MyGestureButton(
                route: 'how_to_use',
                text: 'Uygulama Nasıl Kullanılır',
                icon: Icons.auto_stories_outlined, // Rehber/Okuma ikonu
              ),
              MyGestureButton(
                route: 'stitch_glossary',
                text: 'Terimler ve İkonlar',
                icon: Icons.menu_book_outlined,
              ),
              MyGestureButton(
                route: 'faq',
                text: 'Sık Sorulan Sorular',
                icon: Icons.question_answer_outlined,
              ),
            ],
          ),

          TitleText(text: 'Genel Bilgiler'),
          CardList(
            widgets: [
              MyGestureButton(
                route: 'size_tables',
                text: 'Ölçü Tabloları',
                icon: Icons.straighten_rounded, // Ölçü/Cetvel ikonu
              ),
              MyGestureButton(
                route: 'knitting_care',
                text: 'Örgü Bakımı',
                icon: Icons.wash_outlined, // Yıkama/Bakım ikonu
              ),
              MyGestureButton(
                route: 'knitting_tips',
                text: 'Örgü Örerken Dikkat Edilecekler',
                icon:
                    Icons.lightbulb_outline_rounded, // İpucu/Püf noktası ikonu
              ),
            ],
          ),

          TitleText(text: 'Araçlar'),
          CardList(
            widgets: [
              MyGestureButton(
                route: 'calculators',
                text: 'Hesaplama Araçları',
                icon: Icons.calculate_outlined, // Hesaplama ikonu
              ),
            ],
          ),

          SizedBox(height: 15),
        ],
      ),
    );
  }
}
