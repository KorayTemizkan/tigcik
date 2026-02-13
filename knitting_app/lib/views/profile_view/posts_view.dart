import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/segmented_tab.dart';
import 'package:knitting_app/controllers/widgets/subtitled_info_card_with_image.dart';
import 'package:knitting_app/controllers/widgets/take_note.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/models/how_to_model.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _LikedsViewState();
}

class _LikedsViewState extends State<PostsView> {
  TextEditingController _textController = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final howTos = context.watch<HowToProvider>().howTos;

    return Scaffold(
      appBar: AppBarWidget(title: 'Gönderilerim'),
      body: ListView(
        children: [
          CardList(
            widgets: [
              // --- Üst Aksiyonlar (Sıfırla/Taslak) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.refresh_rounded,
                        size: 20,
                        color: Color(0xFFFF5722),
                      ),
                      label: const Text(
                        'Sıfırla',
                        style: TextStyle(color: Color(0xFFFF5722)),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.save_as_outlined,
                        size: 20,
                        color: Color(0xFFFF5722),
                      ),
                      label: const Text(
                        'Taslağı Kaydet',
                        style: TextStyle(color: Color(0xFFFF5722)),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Ana Metin Girişi ---
              TakeNote(
                minLines: 3,
                controller: _textController,
                labelText: 'Ne örüyorsun? (Örn: Bebek battaniyesi bitmek üzere!)',
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(
                  'Gönderi Detayları',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
              ),

              // --- Teknik Ayrıntılar (İp ve Tığ) ---
             // --- Teknik Ayrıntılar (İp, Tığ ve Zorluk) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. İp Markası (Autocomplete - Yazmaya başlayınca öneren yapı)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          const options = [
                            'Alize Cotton Gold',
                            'Nako Calico',
                            'Gazzal Baby Cotton',
                            'Kartopu Baby One',
                          ];
                          if (textEditingValue.text == '')
                            return const Iterable<String>.empty();
                          return options.where(
                            (String option) =>
                                option.contains(textEditingValue.text),
                          );
                        },
                        fieldViewBuilder:
                            (context, controller, focusNode, onFieldSubmitted) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.colorize,
                                    color: Color(0xFFFF5722),
                                  ),
                                  hintText: 'İp Markası / Türü',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                ),
                              );
                            },
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        // 2. Tığ Numarası (Dropdown)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text("Tığ No"),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFFFF5722),
                                ),
                                items:
                                    [
                                      '2.0mm',
                                      '2.5mm',
                                      '3.0mm',
                                      '3.5mm',
                                      '4.0mm',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (val) {
                                  // setState ile değeri tutabilirsin
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // 3. Zorluk Seviyesi (Açılır Menü)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text("Zorluk"),
                                icon: const Icon(
                                  Icons.speed,
                                  color: Color(0xFFFF5722),
                                ),
                                items: ['Kolay', 'Orta', 'Zor'].map((
                                  String value,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (val) {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // 4. İkili Segment Button (Az önce yaptığımız widget'ı buraya entegre edelim)
                    // Örn: Proje Tipi seçimi
                    const Text(
                      " Örgü Tipi",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    TripleSegmentButton(
                      titles: const ['Tığ İşi', 'Şiş İşi'],
                      selectedIndex: 0, // Örnek değişken
                      onChanged: (index) {},
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Kategori Seç',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),

              // --- Alt Aksiyonlar (Görsel ve Paylaş) ---
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_a_photo_outlined),
                        label: const Text('Görsel Ekle (0/2)'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF5722),
                          side: const BorderSide(color: Color(0xFFFF5722)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5722),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Tığcık\'ta Paylaş',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

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

          TripleSegmentButton(
            titles: ['Gönderilerim', 'Taslaklarım'],
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          CardList(
            widgets: [
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
              SubtitledInfoCardWithImage(
                imageUrl: 'https://via.placeholder.com/150',
                title: 'Amigurumi Ayıcık',
                subtitle: 'Eğitim',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
