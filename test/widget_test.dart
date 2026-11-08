import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/data/models/user_model.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/core/utils/validators.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/data/services/storage_service.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/providers/auth_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('UserModel json serialization test', () {
    final user = UserModel(
      id: 'test_1',
      name: 'Admin Test',
      email: 'admin@test.com',
      password: 'password123',
      role: 'admin',
    );

    final json = user.toJson();
    final restored = UserModel.fromJson(json);

    expect(restored.id, 'test_1');
    expect(restored.name, 'Admin Test');
    expect(restored.email, 'admin@test.com');
    expect(restored.isAdmin, true);
  });

  test('Validators email and password test', () {
    expect(Validators.validateEmail('invalid-email'), isNotNull);
    expect(Validators.validateEmail('test@gmail.com'), isNull);
    expect(Validators.validatePassword('123'), isNotNull);
    expect(Validators.validatePassword('123456'), isNull);
  });

  test('StorageService persists registered user and allows login', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await StorageService.getInstance();
    final authProvider = AuthProvider(storage);

    // Initial users
    expect(authProvider.users.length, 2);

    // Register a new user
    final success = await authProvider.register(
      name: 'Nguyen Van A',
      email: 'nguyenvana@gmail.com',
      password: 'password123',
    );
    expect(success, true);
    expect(authProvider.users.length, 3);

    // Simulate app restart by creating a new AuthProvider with loaded storage
    final loadedUsers = storage.loadUsers();
    expect(loadedUsers.length, 3);
    expect(loadedUsers.any((u) => u.email == 'nguyenvana@gmail.com'), true);

    // Test login
    final authProviderRestarted = AuthProvider(storage);
    final loginSuccess = await authProviderRestarted.login(
      email: 'nguyenvana@gmail.com',
      password: 'password123',
    );
    expect(loginSuccess, true);
    expect(authProviderRestarted.currentUser?.name, 'Nguyen Van A');
  });
}

