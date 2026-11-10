import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    final totalDrinks = drinkProvider.drinks.length;
    final totalCategories = drinkProvider.categories.length;
    final totalIngredients = drinkProvider.ingredients.length;
    final pendingComments = drinkProvider.pendingComments.length;
    final totalUsers = authProvider.users.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.adminDashboard),
        actions: [
          const LanguageToggleButton(),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: l10n.profileTitle,
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thẻ Welcome Admin
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
                        color: AppColors.primary.withValues(alpha: 0.3),
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
                          (user?.name.isNotEmpty == true)
                              ? user!.name[0].toUpperCase()
                              : 'A',
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
                            Text(
                              '${l10n.welcomeAdmin},',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              user?.name ?? l10n.systemAdministrator,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                l10n.systemAdminRole,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Mục Thống kê
                Text(
                  l10n.systemStatistics,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),

                // Grid thống kê đáp ứng (Responsive Card Layout)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 600;

                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: isWide ? 2 : 1,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 12,
                      childAspectRatio: isWide ? 2.9 : 3.8,
                      children: [
                        AdminMetricCard(
                          title: l10n.drinksAndRecipes,
                          value: '$totalDrinks',
                          subtitle: l10n.viewEditRecipes,
                          icon: Icons.local_cafe_rounded,
                          color: AppColors.primary,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ManageDrinksScreen(),
                              ),
                            );
                          },
                        ),
                        AdminMetricCard(
                          title: l10n.drinkCategories,
                          value: '$totalCategories',
                          subtitle: l10n.menuClassification,
                          icon: Icons.category_rounded,
                          color: const Color(0xFF8B5CF6),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ManageCategoriesScreen(),
                              ),
                            );
                          },
                        ),
                        AdminMetricCard(
                          title: l10n.storageIngredients,
                          value: '$totalIngredients',
                          subtitle: l10n.quantitiesAndUnits,
                          icon: Icons.kitchen_rounded,
                          color: AppColors.secondary,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ManageIngredientsScreen(),
                              ),
                            );
                          },
                        ),
                        AdminMetricCard(
                          title: l10n.pendingComments,
                          value: '$pendingComments',
                          subtitle: pendingComments > 0
                              ? l10n.pendingCommentsBadge
                              : l10n.allApproved,
                          icon: Icons.rate_review_rounded,
                          color: pendingComments > 0
                              ? AppColors.error
                              : AppColors.info,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ManageCommentsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Lối tắt quản lý
                Text(
                  l10n.managementShortcuts,
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
                          child: Icon(
                            Icons.local_cafe,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          l10n.manageDrinksRecipes,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(l10n.addEditRecipesIngredients),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ManageDrinksScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 64),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(
                            0xFF8B5CF6,
                          ).withValues(alpha: 0.12),
                          child: const Icon(
                            Icons.category,
                            color: Color(0xFF8B5CF6),
                            size: 20,
                          ),
                        ),
                        title: Text(
                          l10n.manageDrinkCategories,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(l10n.classifyDrinkCategories),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ManageCategoriesScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 64),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.secondary.withValues(
                            alpha: 0.12,
                          ),
                          child: const Icon(
                            Icons.kitchen,
                            color: AppColors.secondary,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          l10n.manageIngredients,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(l10n.ingredientManagementSubtitle),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ManageIngredientsScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 64),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.warning.withValues(
                            alpha: 0.12,
                          ),
                          child: const Icon(
                            Icons.comment,
                            color: AppColors.warning,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          l10n.moderateComments,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          l10n.approveDeleteComments(pendingComments),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ManageCommentsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Thông tin tóm tắt số lượng tài khoản
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.people_alt_outlined,
                        color: AppColors.info,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.registeredUserAccounts(totalUsers),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
