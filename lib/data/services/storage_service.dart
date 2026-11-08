import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../models/user_model.dart';
import '../models/category_model.dart';
import '../models/ingredient_model.dart';
import '../models/drink_model.dart';
import '../models/comment_model.dart';
import '../mock/mock_data.dart';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _prefs;

  StorageService._();

  static Future<StorageService> getInstance() async {
    if (_instance == null) {
      _instance = StorageService._();
      _prefs = await SharedPreferences.getInstance();
      await _instance!._seedInitialDataIfNeeded();
    }
    return _instance!;
  }

  Future<void> _seedInitialDataIfNeeded() async {
    // Tải lại bộ nhớ cache mới nhất từ đĩa/localStorage
    await _prefs?.reload();

    // Kiểm tra độc lập từng bảng, nếu chưa có mới nạp mock ban đầu
    // Đảm bảo TUYỆT ĐỐI không bao giờ ghi đè lên dữ liệu người dùng đã đăng ký / thêm mới
    final hasUsers = _prefs?.containsKey(AppConstants.keyUsers) ?? false;
    if (!hasUsers) {
      await saveUsers(MockData.users);
    }

    final hasCategories =
        _prefs?.containsKey(AppConstants.keyCategories) ?? false;
    if (!hasCategories) {
      await saveCategories(MockData.categories);
    }

    final hasIngredients =
        _prefs?.containsKey(AppConstants.keyIngredients) ?? false;
    if (!hasIngredients) {
      await saveIngredients(MockData.ingredients);
    }

    final hasDrinks = _prefs?.containsKey(AppConstants.keyDrinks) ?? false;
    if (!hasDrinks) {
      await saveDrinks(MockData.drinks);
    }

    final hasComments = _prefs?.containsKey(AppConstants.keyComments) ?? false;
    if (!hasComments) {
      await saveComments(MockData.comments);
    }

    await _prefs?.setBool(AppConstants.keyIsInitialized, true);
  }

  // --- Users ---
  List<UserModel> loadUsers() {
    final rawJson = _prefs?.getString(AppConstants.keyUsers);
    if (rawJson == null || rawJson.isEmpty) {
      return MockData.users;
    }
    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded.map((e) {
        if (e is Map) {
          return UserModel.fromJson(Map<String, dynamic>.from(e));
        }
        return UserModel.fromJson(e as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Lỗi loadUsers từ storage: $e');
      return MockData.users;
    }
  }

  Future<bool> saveUsers(List<UserModel> users) async {
    final encoded = jsonEncode(users.map((e) => e.toJson()).toList());
    final success =
        await _prefs?.setString(AppConstants.keyUsers, encoded) ?? false;
    return success;
  }

  // --- Current User Session ---
  UserModel? loadCurrentUser() {
    final rawJson = _prefs?.getString(AppConstants.keyCurrentUser);
    if (rawJson == null || rawJson.isEmpty) return null;
    try {
      final dynamic decoded = jsonDecode(rawJson);
      if (decoded is Map) {
        return UserModel.fromJson(Map<String, dynamic>.from(decoded));
      }
      return null;
    } catch (e) {
      debugPrint('Lỗi loadCurrentUser: $e');
      return null;
    }
  }

  Future<bool> saveCurrentUser(UserModel? user) async {
    if (user == null) {
      return await _prefs?.remove(AppConstants.keyCurrentUser) ?? false;
    }
    final encoded = jsonEncode(user.toJson());
    return await _prefs?.setString(AppConstants.keyCurrentUser, encoded) ??
        false;
  }

  Future<bool> clearSession() async {
    return await _prefs?.remove(AppConstants.keyCurrentUser) ?? false;
  }

  // --- Categories ---
  List<CategoryModel> loadCategories() {
    final rawJson = _prefs?.getString(AppConstants.keyCategories);
    if (rawJson == null || rawJson.isEmpty) {
      return MockData.categories;
    }
    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded.map((e) {
        if (e is Map) {
          return CategoryModel.fromJson(Map<String, dynamic>.from(e));
        }
        return CategoryModel.fromJson(e as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Lỗi loadCategories: $e');
      return MockData.categories;
    }
  }

  Future<bool> saveCategories(List<CategoryModel> categories) async {
    final encoded = jsonEncode(categories.map((e) => e.toJson()).toList());
    return await _prefs?.setString(AppConstants.keyCategories, encoded) ??
        false;
  }

  // --- Ingredients ---
  List<IngredientModel> loadIngredients() {
    final rawJson = _prefs?.getString(AppConstants.keyIngredients);
    if (rawJson == null || rawJson.isEmpty) {
      return MockData.ingredients;
    }
    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded.map((e) {
        if (e is Map) {
          return IngredientModel.fromJson(Map<String, dynamic>.from(e));
        }
        return IngredientModel.fromJson(e as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Lỗi loadIngredients: $e');
      return MockData.ingredients;
    }
  }

  Future<bool> saveIngredients(List<IngredientModel> ingredients) async {
    final encoded = jsonEncode(ingredients.map((e) => e.toJson()).toList());
    return await _prefs?.setString(AppConstants.keyIngredients, encoded) ??
        false;
  }

  // --- Drinks ---
  List<DrinkModel> loadDrinks() {
    final rawJson = _prefs?.getString(AppConstants.keyDrinks);
    if (rawJson == null || rawJson.isEmpty) {
      return MockData.drinks;
    }
    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded.map((e) {
        if (e is Map) {
          return DrinkModel.fromJson(Map<String, dynamic>.from(e));
        }
        return DrinkModel.fromJson(e as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Lỗi loadDrinks: $e');
      return MockData.drinks;
    }
  }

  Future<bool> saveDrinks(List<DrinkModel> drinks) async {
    final encoded = jsonEncode(drinks.map((e) => e.toJson()).toList());
    return await _prefs?.setString(AppConstants.keyDrinks, encoded) ?? false;
  }

  // --- Comments ---
  List<CommentModel> loadComments() {
    final rawJson = _prefs?.getString(AppConstants.keyComments);
    if (rawJson == null || rawJson.isEmpty) {
      return MockData.comments;
    }
    try {
      final List<dynamic> decoded = jsonDecode(rawJson) as List<dynamic>;
      return decoded.map((e) {
        if (e is Map) {
          return CommentModel.fromJson(Map<String, dynamic>.from(e));
        }
        return CommentModel.fromJson(e as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      debugPrint('Lỗi loadComments: $e');
      return MockData.comments;
    }
  }

  Future<bool> saveComments(List<CommentModel> comments) async {
    final encoded = jsonEncode(comments.map((e) => e.toJson()).toList());
    return await _prefs?.setString(AppConstants.keyComments, encoded) ?? false;
  }
}
