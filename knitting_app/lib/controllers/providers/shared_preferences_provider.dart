// UI ile ilgili bir sınıf olup veri yönetimini sağlar, AppPreferences kullanarak UI rebuild eder ve state yönetimi yapar

// SOLID ilkelerini unutma, Single Responsibility. Hem veri işlemlerini yapıp hem arayüz yönetimi olmazdı. AppPreferences UI bağlı değil ve sadece veri yönetimi yapıyor. Burası ise Apppreferences ve UI arasındaki köprü
import 'package:image_picker/image_picker.dart';
import 'package:knitting_app/controllers/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final AppPreferences _preferences;
  final ImagePicker _picker = ImagePicker();

  SharedPreferencesProvider(this._preferences);

  int get streak => _preferences.streak;
  bool get darkTheme => _preferences.darkTheme;
  String get profilePhoto => _preferences.profilePhoto;
  bool get isFirstOpen => _preferences.isFirstOpen;

  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image == null) {
      return;
    }

    final imagePath = image.path;

    await _preferences.setProfilePhoto(imagePath);
    notifyListeners();
  }

  Future<void> finishSetKnowledgeLevel(String value) async {
    await _preferences.setKnowledgeLevel(value);
  }

  Future<void> toggleTheme() async {
    await _preferences.setDarkTheme(!darkTheme);
    notifyListeners();
  }

  Future<void> increaseStreak() async {
    await _preferences.setStreak(streak + 1);
    notifyListeners();
  }

  Future<void> finishSetLanguage(String value) async {
    await _preferences.setLanguage(value);
    notifyListeners();
  }

  Future<void> finishSetFirstOpening() async {
    await _preferences.setFirstOpening(false);
    notifyListeners();
  }

  Future<void> finishSetFirstOpeningTrue() async {
    await _preferences.setFirstOpening(true);
    notifyListeners();
  }

  Future<void> finishSetFirstOpenAfterUpdate() async {
    await _preferences.setFirstOpeningAfterUpdate(false);
    notifyListeners();
  }

  //********/

  Future<void> finishSaveCharacter(int characterId) async {
    await _preferences.saveCharacter(characterId);
    notifyListeners();
  }

  Future<void> finishRemoveCharacter(int characterId) async {
    await _preferences.removeCharacter(characterId);
    notifyListeners();
  }

  Future<List<String>> finishGetSavedCharacters() async {
    return await _preferences.getSavedCharacters();
  }
}

// BEĞENMELERİ EKLEMEMİŞİn
