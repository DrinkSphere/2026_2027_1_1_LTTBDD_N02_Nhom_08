import 'package:flutter_test/flutter_test.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/data/models/user_model.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/core/utils/validators.dart';

void main() {
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
}
