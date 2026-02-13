import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/knitting_cafe_provider.dart';
import 'package:knitting_app/controllers/providers/supabase_provider.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/comment_section.dart';
import 'package:knitting_app/controllers/widgets/content_card.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/horizontal_card_list.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/take_note.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/controllers/widgets/title_with_see_all.dart';
import 'package:knitting_app/controllers/widgets/weekly_stars_card.dart';
import 'package:knitting_app/models/profile_model.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({super.key});

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  int selectedIndex = 0;

  List<ProfileModel> profiles = [];

  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  String? _imagePath = '';
  String imageUrl = '';
  Future<void> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _imagePath = image.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    context.read<SupabaseProvider>().readPosts();
    profiles = context.read<SupabaseProvider>().profiles;
  }

  @override
  Widget build(BuildContext context) {
    final knittingCafes = context.watch<KnittingCafeProvider>().knittingCafes;

    return Scaffold(
      appBar: AppBarWidget(title: 'Topluluk'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/community/createPost');
        },
        backgroundColor: Color(0xFFFF5722),
        child: const Icon(Icons.add, size: 24, color: Colors.white),
        shape: const CircleBorder(),
      ),

      body: ListView(
        children: [
          TitleWithSeeAll(text: 'Örgü Kafeler'),

          HorizontalCardList(
            itemCount: knittingCafes.length,
            height: 260, // yükseklik
            cardWidthRatio: 0.6, // sağdan solal yüzde kaç oranı
            itemBuilder: (context, index) {
              final knittingCafe = knittingCafes[index];

              return ContentCard(
                title: knittingCafe.name,
                difficulty: knittingCafe.phone,
                estimatedHour: knittingCafe.address,
                onTap: () {},
              );
            },
          ),

          TitleWithSeeAll(text: 'Haftanın Yıldızları'),

          HorizontalCardList(
            itemCount: 20,
            height: 120,
            cardWidthRatio: 0.18,
            itemBuilder: (context, index) {
              return WeeklyStarsCard(
                title: "@kkkkorayyyy",
                difficulty: "540 tığcık",
                estimatedHour: "",
                onTap: () {},
              );
            },
          ),

          TitleText(text: 'Akış'),

          TripleSegmentButton(
            titles: ['Herkes', 'Takip'],
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          PostCard(showComments: true),
          PostCard(showComments: true),
          PostCard(showComments: true),
          PostCard(showComments: true),

          //PostCard(showComments: true), // 👈
          //PostCard(showComments: true), // 👈
          //PostCard(showComments: true), // 👈
          //PostCard(showComments: true), // 👈
          /*
            SizedBox(height: 10),

            if (profiles.isEmpty) CircularProgressIndicator(),

            Text('GÖNDERİ ATMA'),

            TextField(
              controller: _headerController,
              decoration: InputDecoration(
                labelText: 'Başlık',
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'İçerik',
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                pickImage();
              },
              child: Text('Görsel seç'),
            ),

            if (_selectedImage != null)
              Image.file(_selectedImage!, height: 200, fit: BoxFit.cover),

            ElevatedButton(
              onPressed: () async {
                await context.read<SupabaseProvider>().uploadPhoto(
                  selectedImage: _selectedImage!,
                );
                await context.read<SupabaseProvider>().insert(
                  header: _headerController.text,
                  content: _contentController.text,
                );
              },
              child: Text('Paylaş'),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('TÜM KULLANICILAR'),

            Expanded(
              child:
                  context.watch<SupabaseProvider>().internetConnectionController
                  ? ListView.builder(
                      itemCount: profiles.length,
                      itemBuilder: (context, index) {
                        final user = profiles[index];

                        return Card(
                          child: ListTile(
                            title: Text(user.firstName),
                            subtitle: Text(user.lastName),
                          ),
                        );
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 12),
                        Text('Lütfen internet bağlantınızı kontrol edin!'), // KONTROL EKSİK
                      ],
                    ),
            ),

            Divider(height: 50, thickness: 15, color: Colors.amber),

            Text('GÖNDERİLERİM'),
          
            Expanded(
              child: context.read<SupabaseProvider>().internetConnectionController 
              ? Consumer<SupabaseProvider>(
                // provider içindeki veriyi dinleyip sadece o widgeti yeniden çizmek için kullanılan bir widgettir.
                builder: (context, provider, _) {
                  final posts = provider.posts;

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final p = posts[index];

                      return Card(
                        child: ListTile(
                          title: Text(p['header'] ?? ''),
                          subtitle: Text(p['content'] ?? ''),
                        ),
                      );
                    },
                  );
                },
              ) : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Lütfen internet bağlantınızı kontrol edin!') // KONTROL EKSİK
                ],
              )
            ),

            // Tüm gönderiler
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),

            // Takipçi sayısına göre kişiler
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),
            //Kişi ara: GenericSearchAnchorBar(items: items, onItemSelected: onItemSelected)

            // Takipçi sayısına göre topluluklar
            //ListView.builder(itemCount: 10, itemBuilder: (context, index) {}),
            //Topluluk ara: GenericSearchAnchorBar(items: items, onItemSelected: onItemSelected)
            */
        ],
      ),
    );
  }
}
