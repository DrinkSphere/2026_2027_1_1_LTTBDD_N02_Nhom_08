import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final StorageService _storage;

  UserModel? _currentUser;
  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._storage) {
    _init();
  }

  UserModel? get currentUser => _currentUser;
  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  void _init() {
    _users = _storage.loadUsers();
    _currentUser = _storage.loadCurrentUser();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // 1.2 Đăng ký tài khoản
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String role = 'user',
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Giả lập delay mạng
    await Future.delayed(const Duration(milliseconds: 500));

    final normalizedEmail = email.trim().toLowerCase();
    final isExist = _users.any((u) => u.email.toLowerCase() == normalizedEmail);

    if (isExist) {
      _errorMessage = 'Email "$email" đã được đăng ký trên hệ thống.';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    final newUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name.trim(),
      email: normalizedEmail,
      password: password,
      phone: phone?.trim(),
      role: role,
      createdAt: DateTime.now(),
    );

    _users.add(newUser);
    await _storage.saveUsers(_users);

    // Tự động đăng nhập người dùng mới tạo
    _currentUser = newUser;
    await _storage.saveCurrentUser(newUser);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // 1.3 Đăng nhập
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    final normalizedEmail = email.trim().toLowerCase();
    final index = _users.indexWhere(
      (u) => u.email.toLowerCase() == normalizedEmail && u.password == password,
    );

    if (index == -1) {
      _errorMessage = 'Email hoặc mật khẩu không chính xác.';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _currentUser = _users[index];
    await _storage.saveCurrentUser(_currentUser);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // 1.3 Quên mật khẩu & Đặt lại mật khẩu mới
  Future<bool> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    final normalizedEmail = email.trim().toLowerCase();
    final index = _users.indexWhere((u) => u.email.toLowerCase() == normalizedEmail);

    if (index == -1) {
      _errorMessage = 'Không tìm thấy tài khoản với email "$email".';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _users[index] = _users[index].copyWith(password: newPassword);
    await _storage.saveUsers(_users);

    // Cập nhật session nếu chính là user hiện tại
    if (_currentUser?.email.toLowerCase() == normalizedEmail) {
      _currentUser = _users[index];
      await _storage.saveCurrentUser(_currentUser);
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // 1.4 Quản lý tài khoản: Cập nhật thông tin người dùng
  Future<bool> updateProfile({
    required String name,
    String? phone,
    String? avatarUrl,
    String? currentPassword,
    String? newPassword,
  }) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 400));

    // Nếu muốn đổi mật khẩu, kiểm tra mật khẩu hiện tại
    if (newPassword != null && newPassword.isNotEmpty) {
      if (currentPassword == null || currentPassword != _currentUser!.password) {
        _errorMessage = 'Mật khẩu hiện tại không chính xác.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    }

    final updatedUser = _currentUser!.copyWith(
      name: name.trim(),
      phone: phone?.trim(),
      avatarUrl: avatarUrl?.trim(),
      password: (newPassword != null && newPassword.isNotEmpty)
          ? newPassword
          : _currentUser!.password,
    );

    final index = _users.indexWhere((u) => u.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
      await _storage.saveUsers(_users);
    }

    _currentUser = updatedUser;
    await _storage.saveCurrentUser(updatedUser);

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // 1.4 Đăng xuất và xóa phiên đăng nhập
  Future<void> logout() async {
    _currentUser = null;
    await _storage.clearSession();
    notifyListeners();
  }
}
