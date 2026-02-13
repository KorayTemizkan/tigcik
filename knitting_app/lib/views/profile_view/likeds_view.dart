import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/how_to_provider.dart';
import 'package:knitting_app/controllers/providers/product_provider.dart';
import 'package:knitting_app/controllers/widgets/card_list.dart';
import 'package:knitting_app/controllers/widgets/generic_search_anchor_bar.dart';
import 'package:knitting_app/controllers/widgets/subtitled_info_card_with_image.dart';
import 'package:knitting_app/controllers/widgets/title_text.dart';
import 'package:knitting_app/models/how_to_model.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/models/searchable_model.dart';
import 'package:provider/provider.dart';

class LikedsView extends StatefulWidget {
  const LikedsView({super.key});

  @override
  State<LikedsView> createState() => _LikedsViewState();
}

class _LikedsViewState extends State<LikedsView> {
  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;
    final howTos = context.watch<HowToProvider>().howTos;

    return Scaffold(
      appBar: AppBarWidget(title: 'Beğenilenler'),
      body: ListView(
        children: [

          SizedBox(height: 15),
          
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
