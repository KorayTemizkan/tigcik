// En üstteki görsel kısım ve sağ altta bilgi kutusu

import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Stack yapısı widgetleri üst üste koymak için yapılır
    return Stack(
      children: [
        // Arka plan görseli
        Column(
          children: [
            Stack(
              clipBehavior:
                  Clip.none, // İçeriğin görselin üzerine taşması için şart
              children: [
                // 1. ANA GÖRSEL (Turuncu Alan)
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5722),
                    // Buranın altını yumuşatmıyoruz, düz bırakıyoruz
                  ),
                  child: const Center(
                    child: Icon(Icons.image, size: 50, color: Colors.white),
                  ),
                ),

                // 2. MANİPÜLASYON ALANI (Sarı/Beyaz İçerik Başlangıcı)
                // Bu container'ı görselin bittiği yere yerleştirip biraz yukarı çekiyoruz
                Positioned(
                  bottom:
                      -1, // Görselle arasında boşluk kalmasın diye tam sıfırlıyoruz
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30, // Kavisin derinliği kadar yükseklik
                    decoration: const BoxDecoration(
                      color: Colors
                          .white, // Uygulama arka plan rengin neyse o olmalı
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Sağdaki Yüzen İstatistik Kutusu
        Positioned(
          right: 20,
          bottom: 40,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _miniStat(Icons.visibility_outlined, "157"),
                _miniStat(Icons.favorite_border, "18"),
                _miniStat(Icons.bookmark_border, "27"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _miniStat(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [Icon(icon, size: 16), SizedBox(width: 4), Text(text)],
      ),
    );
  }
}
