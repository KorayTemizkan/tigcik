import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/app_bar.dart';
import 'package:knitting_app/controllers/providers/database_provider.dart';
import 'package:provider/provider.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final dbProvider = context.watch<DatabaseProvider>();

    return Scaffold(
      appBar: const AppBarWidget(title: 'Notlarım'),
      body: Builder(
        builder: (context) {
          if (dbProvider.isLoading || !dbProvider.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: dbProvider.notepadDatabase.query('notes', orderBy: 'id DESC'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Hata: ${snapshot.error}'));
              }

              final notes = snapshot.data ?? [];
              if (notes.isEmpty) {
                return const Center(child: Text('Henüz not yok'));
              }

              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final n = notes[index];
                  return ListTile(
                    title: Text(n['noteName']?.toString() ?? ''),
                    subtitle: Text('id: ${n['id']}'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
