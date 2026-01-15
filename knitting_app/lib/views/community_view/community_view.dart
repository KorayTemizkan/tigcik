import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Topluluk'),
      body: Center(
        child: Column(
          children: [
            /*
            Bu kısımla ilgili düşüncelerim tam net değil ama şimdilik orta boyutta bir logomuzu buraya koyup yakında! uyarısı versek yeter sanırım.
            
            4 UNSUR OLUCAK
            
            Facebook gönderi atabilme: Gönderi atabilme, takip ettiğin insanların gönderileri ya da 
            Facebook profilleri ve arama:Farklı kullanıcıları görebilme, profil sayfalarına gidebilme olsun. - Kullanıcı arama olsun, ama normal olarak ayın enleri yapalım. aktiflik sıralamasına göre ayın 50'si filan olsun
            Facebook grupları: Örgü kafe toplulukları olsun. O kafelerin sahipleri doğrulama yaparsa onlar eklenebilir mesela. Ya da birisi Bursa Nilüferciler diye bir topluluk kursun ve üyeleri olsun. Bu toplulukların sayfası olsun. Bu topluluklarda gönderi atılınca sadece buraya özel olsun. Bu topluluğa giriş onayla olsun.
            
            Mesajlaşma yerine gönderilere yorum atma olsun şimdilik
            */
            TextField(
              controller: _postController,
              decoration: InputDecoration(
                labelText: 'Ne düşünüyorsun',
                border: OutlineInputBorder(),
              ),
            ),
            Text('Fotoğraf ekle'),

            ElevatedButton(onPressed: () {}, child: Text('Paylaş')),

            Divider(height: 50, thickness: 15, color: Colors.amber),


            // Tüm gönderiler 
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),

            // Takipçi sayısına göre kişiler 
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),
            //Kişi ara: GenericSearchAnchorBar(items: items, onItemSelected: onItemSelected)

            // Takipçi sayısına göre topluluklar
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),
            //Topluluk ara: GenericSearchAnchorBar(items: items, onItemSelected: onItemSelected)


          ],
        ),
      ),
    );
  }
}
