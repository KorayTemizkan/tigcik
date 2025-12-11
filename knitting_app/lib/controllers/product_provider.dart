import 'package:flutter/material.dart';
import 'package:knitting_app/controllers/api_services.dart';
import 'package:knitting_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [];
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  bool get isLoading => _isLoading;



  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners(); // provideri dinleyen tüm widgetler, kendinizi yeniden yükleyin demek

    _products = await fetchProducts();

    _isLoading = false;
    notifyListeners();
  }
}
