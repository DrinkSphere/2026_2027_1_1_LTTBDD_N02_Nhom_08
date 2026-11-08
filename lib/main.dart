import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'data/services/storage_service.dart';
import 'features/admin/screens/admin_dashboard_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/user/screens/user_main_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/drink_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await StorageService.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(storage)),
        ChangeNotifierProvider(create: (_) => DrinkProvider(storage)),
      ],
      child: const DrinkRecipeApp(),
    ),
  );
}

class DrinkRecipeApp extends StatelessWidget {
  const DrinkRecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    // Nếu chưa đăng nhập -> hiển thị màn hình Đăng nhập
    if (!authProvider.isAuthenticated) {
      return const LoginScreen();
    }

    // Nếu đã đăng nhập và là Admin -> chuyển vào Admin Dashboard
    if (authProvider.isAdmin) {
      return const AdminDashboardScreen();
    }

    // Ngược lại nếu là User bình thường -> chuyển vào UserMainScreen
    return const UserMainScreen();
  }
}
