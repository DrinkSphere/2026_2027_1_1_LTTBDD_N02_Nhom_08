import 'package:flutter/material.dart';
import '../data/models/drink_model.dart';
import '../data/models/category_model.dart';
import '../data/models/ingredient_model.dart';
import '../data/models/comment_model.dart';
import '../data/mock/mock_data.dart';
import '../data/services/storage_service.dart';

class DrinkProvider extends ChangeNotifier {
  final StorageService _storage;

  List<DrinkModel> _drinks = [];
  List<CategoryModel> _categories = [];
  List<IngredientModel> _ingredients = [];
  List<CommentModel> _comments = [];

  String _selectedCategoryId = 'all';
  String _searchQuery = '';
  final bool _isLoading = false;

  DrinkProvider(this._storage) {
    _init();
  }

  List<DrinkModel> get drinks => _drinks;
  List<CategoryModel> get categories => _categories;
  List<IngredientModel> get ingredients => _ingredients;
  List<CommentModel> get comments => _comments;
  bool get isLoading => _isLoading;
  String get selectedCategoryId => _selectedCategoryId;
  String get searchQuery => _searchQuery;

  void _init() {
    _drinks = _storage.loadDrinks();
    _categories = _storage.loadCategories();
    _ingredients = _storage.loadIngredients();
    _comments = _storage.loadComments();

    // Xóa các bình luận mẫu cũ theo yêu cầu người dùng
    final hadOldComments = _comments.any(
      (c) => c.id == 'cmt_1' || c.id == 'cmt_2' || c.id == 'cmt_3',
    );
    if (hadOldComments) {
      _comments.removeWhere(
        (c) => c.id == 'cmt_1' || c.id == 'cmt_2' || c.id == 'cmt_3',
      );
      _storage.saveComments(_comments);
    }

    // Cập nhật lại link ảnh mới sắc nét hơn cho các đồ uống mặc định nếu đang lưu link cũ
    bool updatedDrinks = false;
    for (int i = 0; i < _drinks.length; i++) {
      if (_drinks[i].id == 'drink_1' &&
          !_drinks[i].imageUrl.contains('photo-1514432324607')) {
        _drinks[i] = _drinks[i].copyWith(
          imageUrl:
              'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=800',
        );
        updatedDrinks = true;
      } else if (_drinks[i].id == 'drink_2' &&
          !_drinks[i].imageUrl.contains('photo-1558857563')) {
        _drinks[i] = _drinks[i].copyWith(
          imageUrl:
              'https://images.unsplash.com/photo-1558857563-b371033873b8?w=800',
        );
        updatedDrinks = true;
      } else if (_drinks[i].id == 'drink_3' &&
          !_drinks[i].imageUrl.contains('photo-1551024709')) {
        _drinks[i] = _drinks[i].copyWith(
          imageUrl:
              'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=800',
        );
        updatedDrinks = true;
      }
    }
    // Tự động bổ sung các công thức mới cho từng danh mục (Bạc xỉu, Trà đào cam sả, Nước ép...) nếu chưa có
    for (var mockDrink in MockData.drinks) {
      if (!_drinks.any((d) => d.id == mockDrink.id)) {
        _drinks.add(mockDrink);
        updatedDrinks = true;
      }
    }

    if (updatedDrinks) {
      _storage.saveDrinks(_drinks);
    }
  }

  // Filtered drinks for UI
  List<DrinkModel> get filteredDrinks {
    return _drinks.where((d) {
      final matchesCategory =
          _selectedCategoryId == 'all' || d.categoryId == _selectedCategoryId;
      final matchesSearch =
          _searchQuery.isEmpty ||
          d.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          d.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void setCategoryFilter(String categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // --- CRUD DRINKS ---
  Future<void> addDrink(DrinkModel drink) async {
    _drinks.insert(0, drink);
    await _storage.saveDrinks(_drinks);
    notifyListeners();
  }

  Future<void> updateDrink(DrinkModel updated) async {
    final index = _drinks.indexWhere((d) => d.id == updated.id);
    if (index != -1) {
      _drinks[index] = updated;
      await _storage.saveDrinks(_drinks);
      notifyListeners();
    }
  }

  Future<void> deleteDrink(String id) async {
    _drinks.removeWhere((d) => d.id == id);
    // Xóa cả bình luận thuộc về đồ uống này
    _comments.removeWhere((c) => c.drinkId == id);
    await _storage.saveDrinks(_drinks);
    await _storage.saveComments(_comments);
    notifyListeners();
  }

  DrinkModel? getDrinkById(String id) {
    try {
      return _drinks.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  // --- CRUD CATEGORIES ---
  Future<void> addCategory(CategoryModel category) async {
    _categories.add(category);
    await _storage.saveCategories(_categories);
    notifyListeners();
  }

  Future<void> updateCategory(CategoryModel updated) async {
    final index = _categories.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      _categories[index] = updated;
      await _storage.saveCategories(_categories);
      notifyListeners();
    }
  }

  Future<void> deleteCategory(String id) async {
    _categories.removeWhere((c) => c.id == id);
    await _storage.saveCategories(_categories);
    notifyListeners();
  }

  String getCategoryName(String id) {
    try {
      return _categories.firstWhere((c) => c.id == id).name;
    } catch (_) {
      return 'Chưa phân loại';
    }
  }

  // --- CRUD INGREDIENTS ---
  Future<void> addIngredient(IngredientModel ingredient) async {
    _ingredients.add(ingredient);
    await _storage.saveIngredients(_ingredients);
    notifyListeners();
  }

  Future<void> updateIngredient(IngredientModel updated) async {
    final index = _ingredients.indexWhere((i) => i.id == updated.id);
    if (index != -1) {
      _ingredients[index] = updated;
      await _storage.saveIngredients(_ingredients);
      notifyListeners();
    }
  }

  Future<void> deleteIngredient(String id) async {
    _ingredients.removeWhere((i) => i.id == id);
    await _storage.saveIngredients(_ingredients);
    notifyListeners();
  }

  // --- COMMENTS MANAGEMENT (Mục 1.5 Kiểm duyệt bình luận) ---
  List<CommentModel> getCommentsForDrink(String drinkId) {
    return _comments
        .where((c) => c.drinkId == drinkId && c.isApproved)
        .toList();
  }

  List<CommentModel> get pendingComments {
    return _comments.where((c) => !c.isApproved).toList();
  }

  Future<void> addComment(CommentModel comment) async {
    _comments.insert(0, comment);
    await _storage.saveComments(_comments);
    notifyListeners();
  }

  Future<bool> updateUserComment({
    required String commentId,
    required String userId,
    required String content,
    required double rating,
  }) async {
    final index = _comments.indexWhere((comment) => comment.id == commentId);
    if (index == -1 ||
        _comments[index].userId != userId ||
        content.trim().isEmpty ||
        rating < 1 ||
        rating > 5) {
      return false;
    }

    final original = _comments[index];
    _comments[index] = original.copyWith(
      content: content.trim(),
      rating: rating,
      isApproved: false,
    );
    final saved = await _storage.saveComments(_comments);
    if (!saved) {
      _comments[index] = original;
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<bool> deleteUserComment({
    required String commentId,
    required String userId,
  }) async {
    final index = _comments.indexWhere((comment) => comment.id == commentId);
    if (index == -1 || _comments[index].userId != userId) {
      return false;
    }

    final removed = _comments.removeAt(index);
    final saved = await _storage.saveComments(_comments);
    if (!saved) {
      _comments.insert(index, removed);
      return false;
    }

    notifyListeners();
    return true;
  }

  Future<void> approveComment(String id) async {
    final index = _comments.indexWhere((c) => c.id == id);
    if (index != -1) {
      _comments[index] = _comments[index].copyWith(isApproved: true);
      await _storage.saveComments(_comments);
      notifyListeners();
    }
  }

  Future<void> deleteComment(String id) async {
    _comments.removeWhere((c) => c.id == id);
    await _storage.saveComments(_comments);
    notifyListeners();
  }
}
