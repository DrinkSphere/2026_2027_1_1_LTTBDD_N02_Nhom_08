import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/drink_provider.dart';
import '../../admin/screens/admin_dashboard_screen.dart';
import '../../auth/screens/login_screen.dart';
import 'about_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _confirmLogout(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error),
            SizedBox(width: 8),
            Text(l10n.logout),
          ],
        ),
        content: Text(l10n.logout),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final navigator = Navigator.of(context, rootNavigator: true);
              Navigator.of(ctx).pop(); // Đóng hộp thoại xác nhận
              await context.read<AuthProvider>().logout();
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final drinkProvider = context.watch<DrinkProvider>();
    final user = authProvider.currentUser;
    final l10n = AppLocalizations.of(context)!;

    final myCommentsCount = drinkProvider.comments
        .where((c) => c.userId == user?.id)
        .length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        actions: [
          const LanguageToggleButton(),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: l10n.aboutTitle,
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const AboutScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: l10n.editProfile,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Header card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 46,
                        backgroundColor: AppColors.primaryLight,
                        backgroundImage:
                            (user?.avatarUrl != null &&
                                user!.avatarUrl!.isNotEmpty)
                            ? NetworkImage(user.avatarUrl!)
                            : null,
                        child:
                            (user?.avatarUrl == null ||
                                user!.avatarUrl!.isEmpty)
                            ? const Icon(
                                Icons.person,
                                size: 48,
                                color: AppColors.primary,
                              )
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        user?.name ?? l10n.systemAdministrator,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Role Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: user?.isAdmin == true
                              ? AppColors.primaryLight
                              : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              user?.isAdmin == true
                                  ? Icons.admin_panel_settings_rounded
                                  : Icons.verified_user_rounded,
                              size: 16,
                              color: user?.isAdmin == true
                                  ? AppColors.primary
                                  : AppColors.info,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              user?.isAdmin == true
                                  ? l10n.adminRole
                                  : l10n.userRole,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: user?.isAdmin == true
                                    ? AppColors.primaryDark
                                    : AppColors.info,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Thống kê bình luận & đóng góp
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: AppColors.secondary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.submittedComments,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              l10n.submittedCommentsDescription,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$myCommentsCount',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Menu Items
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person_outline,
                          color: AppColors.primary,
                        ),
                        title: Text(
                          l10n.editProfile,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.textLight,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const EditProfileScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1, indent: 56),

                      // Nếu là admin, hiển thị lối tắt vào Dashboard
                      if (user?.isAdmin == true) ...[
                        ListTile(
                          leading: const Icon(
                            Icons.dashboard_outlined,
                            color: AppColors.primary,
                          ),
                          title: Text(
                            l10n.adminDashboard,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColors.textLight,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const AdminDashboardScreen(),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 56),
                      ],

                      ListTile(
                        leading: const Icon(
                          Icons.phone_android_outlined,
                          color: AppColors.textSecondary,
                        ),
                        title: Text(
                          l10n.phone,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          user?.phone ?? 'Chưa cập nhật',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        leading: const Icon(
                          Icons.calendar_today_outlined,
                          color: AppColors.textSecondary,
                        ),
                        title: Text(
                          l10n.joinedDate,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: Text(
                          user?.createdAt != null
                              ? '${user!.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}'
                              : '--/--',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _confirmLogout(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_rounded, size: 20),
                        SizedBox(width: 8),
                        Text(
                          l10n.logout,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
