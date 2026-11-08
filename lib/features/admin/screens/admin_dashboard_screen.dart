import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/drink_provider.dart';
import '../../profile/screens/profile_screen.dart';
import '../widgets/admin_metric_card.dart';
import 'manage_categories_screen.dart';
import 'manage_drinks_screen.dart';
import 'manage_ingredients_screen.dart';
import 'manage_comments_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final drinkProvider = context.watch<DrinkProvider>();
    final user = authProvider.currentUser;

    final totalDrinks = drinkProvider.drinks.length;
    final totalCategories = drinkProvider.categories.length;
    final totalIngredients = drinkProvider.ingredients.length;
    final pendingComments = drinkProvider.pendingComments.length;
    final totalUsers = authProvider.users.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Hồ sơ Admin',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Text(
                      (user?.name.isNotEmpty == true) ? user!.name[0].toUpperCase() : 'A',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Xin chào Admin,',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        Text(
                          user?.name ?? 'Quản trị viên',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Toàn quyền Quản trị Hệ thống',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section: Metrics
            const Text(
              'Thống kê hệ thống',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                AdminMetricCard(
                  title: 'Đồ uống & Công thức',
                  value: '$totalDrinks',
                  icon: Icons.local_cafe_rounded,
                  color: AppColors.primary,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ManageDrinksScreen()),
                    );
                  },
                ),
                AdminMetricCard(
                  title: 'Danh mục đồ uống',
                  value: '$totalCategories',
                  icon: Icons.category_rounded,
                  color: const Color(0xFF8B5CF6),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ManageCategoriesScreen()),
                    );
                  },
                ),
                AdminMetricCard(
                  title: 'Nguyên liệu kho',
                  value: '$totalIngredients',
                  icon: Icons.kitchen_rounded,
                  color: AppColors.secondary,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ManageIngredientsScreen()),
                    );
                  },
                ),
                AdminMetricCard(
                  title: 'Bình luận chờ duyệt',
                  value: '$pendingComments',
                  icon: Icons.rate_review_rounded,
                  color: pendingComments > 0 ? AppColors.error : AppColors.info,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ManageCommentsScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Section: Quick links
            const Text(
              'Lối tắt quản lý',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(Icons.local_cafe, color: AppColors.primary, size: 20),
                    ),
                    title: const Text('Quản lý Đồ uống & Công thức', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Thêm, sửa công thức, định lượng nguyên liệu'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ManageDrinksScreen()),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 64),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.12),
                      child: const Icon(Icons.category, color: Color(0xFF8B5CF6), size: 20),
                    ),
                    title: const Text('Quản lý Danh mục đồ uống', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Phân loại cà phê, trà sữa, sinh tố, mocktail'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ManageCategoriesScreen()),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 64),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary.withOpacity(0.12),
                      child: const Icon(Icons.kitchen, color: AppColors.secondary, size: 20),
                    ),
                    title: const Text('Quản lý Nguyên liệu', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Kho nguyên liệu, đơn vị tính chuẩn'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ManageIngredientsScreen()),
                      );
                    },
                  ),
                  const Divider(height: 1, indent: 64),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.warning.withOpacity(0.12),
                      child: const Icon(Icons.comment, color: AppColors.warning, size: 20),
                    ),
                    title: const Text('Kiểm duyệt Bình luận', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Duyệt hoặc xóa bình luận ($pendingComments chờ xử lý)'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ManageCommentsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // User count summary info banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                children: [
                  const Icon(Icons.people_alt_outlined, color: AppColors.info),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Hệ thống hiện có $totalUsers tài khoản người dùng đăng ký.',
                      style: const TextStyle(fontSize: 13, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

