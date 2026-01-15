class Note { // veri modeli - varlık - entity. 
  // Alanlar (Fields)
  final int id; // içinde id geçtiği için primary key
  String title; // düzenlenebilir başlık
  String note;  // düzenlenebilir metin
  final DateTime time; // düzenlenemez tarih ? düzelt

  Note({ // constructor - yapıcı fonksiyon
    required this.id,
    required this.title,
    required this.note,
    required this.time,
  });

  Map<String, Object?> toMap() { // Dart nesnesini sqlite formatına çeviriyor
    return {
      'id': id,
      'title': title,
      'note': note,
      'time': time.millisecondsSinceEpoch,
    };
  }
  
  factory Note.fromMap(Map<String, dynamic> map) { // SQLite'dan gelen mapi dart nesnesine çevirir
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      note: map['note'] as String,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
  
   @override
  String toString() { // Debug için eklendi
    return 'Note{id: $id, title: $title, note: $note, time: $time}';
  }
}
