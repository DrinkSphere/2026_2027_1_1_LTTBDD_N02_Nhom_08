import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../providers/auth_provider.dart';
import '../../auth/widgets/auth_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _avatarController;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isChangingPassword = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().currentUser;
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _avatarController = TextEditingController(text: user?.avatarUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _avatarController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.updateProfile(
      name: _nameController.text,
      phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
      avatarUrl: _avatarController.text.isNotEmpty ? _avatarController.text : null,
      currentPassword: _isChangingPassword ? _currentPasswordController.text : null,
      newPassword: _isChangingPassword ? _newPasswordController.text : null,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text('Cập nhật thông tin thành công!')),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    } else {
      final errorMsg = authProvider.errorMessage ?? 'Cập nhật thất bại.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text(errorMsg)),
            ],
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Chỉnh Sửa Thông Tin'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar preview
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primaryLight,
                        backgroundImage: _avatarController.text.isNotEmpty
                            ? NetworkImage(_avatarController.text)
                            : (user?.avatarUrl != null && user!.avatarUrl!.isNotEmpty)
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                        child: (_avatarController.text.isEmpty &&
                                (user?.avatarUrl == null || user!.avatarUrl!.isEmpty))
                            ? const Icon(Icons.person, size: 50, color: AppColors.primary)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Họ và tên
                AuthTextField(
                  controller: _nameController,
                  label: 'Họ và tên',
                  hintText: 'Nhập họ và tên',
                  prefixIcon: Icons.badge_outlined,
                  validator: (val) => Validators.validateRequired(val, 'họ và tên'),
                ),
                const SizedBox(height: 16),

                // Email (Readonly)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Địa chỉ Email (Cố định)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      initialValue: user?.email ?? '',
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        prefixIcon: const Icon(Icons.email_outlined, color: AppColors.textLight),
                        suffixIcon: const Tooltip(
                          message: 'Email dùng làm định danh, không thể thay đổi',
                          child: Icon(Icons.lock_outline, color: AppColors.textLight, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Số điện thoại
                AuthTextField(
                  controller: _phoneController,
                  label: 'Số điện thoại',
                  hintText: '0901234567',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validatePhone,
                ),
                const SizedBox(height: 16),

                // Avatar URL
                AuthTextField(
                  controller: _avatarController,
                  label: 'Đường dẫn ảnh đại diện (URL)',
                  hintText: 'https://images.unsplash.com/...',
                  prefixIcon: Icons.image_outlined,
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 24),

                // Toggle đổi mật khẩu
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.password_outlined, color: AppColors.primary, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Đổi mật khẩu tài khoản',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: _isChangingPassword,
                            activeColor: AppColors.primary,
                            onChanged: (val) {
                              setState(() {
                                _isChangingPassword = val;
                              });
                            },
                          ),
                        ],
                      ),
                      if (_isChangingPassword) ...[
                        const Divider(height: 20),
                        AuthTextField(
                          controller: _currentPasswordController,
                          label: 'Mật khẩu hiện tại',
                          hintText: 'Nhập mật khẩu đang dùng',
                          prefixIcon: Icons.lock_outline,
                          obscureText: _obscureCurrentPassword,
                          validator: _isChangingPassword
                              ? (val) => Validators.validateRequired(val, 'mật khẩu hiện tại')
                              : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureCurrentPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureCurrentPassword = !_obscureCurrentPassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        AuthTextField(
                          controller: _newPasswordController,
                          label: 'Mật khẩu mới',
                          hintText: 'Tối thiểu 6 ký tự',
                          prefixIcon: Icons.lock_reset_outlined,
                          obscureText: _obscureNewPassword,
                          validator: _isChangingPassword ? Validators.validatePassword : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureNewPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Nút Lưu
                ElevatedButton(
                  onPressed: authProvider.isLoading ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: authProvider.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : const Text(
                          'Lưu Thay Đổi',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
