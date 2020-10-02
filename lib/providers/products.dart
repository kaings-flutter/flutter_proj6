import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  // moved all dummy items here since this the Products state is managed here
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavorite = false;

  List<Product> get items {
    // if (_showFavorite == true) {
    //   return _items.where((item) => item.isFavorite).toList();
    // }

    return [
      ..._items
    ]; // use spread operator to create instance instead of the array itself to avoid being mutated
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addProduct(Product newProduct) {
    _items.add(newProduct); // to add new product at the end of List
    // _items.insert(0, newProduct); // to add new product at the beginning of List

    notifyListeners();
  }

  void removeProduct(String id) {
    _items.removeWhere((item) => item.id == id);

    notifyListeners();
  }

  // void showFavorite() {
  //   _showFavorite = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavorite = false;
  //   notifyListeners();
  // }
}
