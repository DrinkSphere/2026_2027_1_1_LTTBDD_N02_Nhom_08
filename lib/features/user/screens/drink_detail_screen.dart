import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/models/drink_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/drink_provider.dart';

class DrinkDetailScreen extends StatefulWidget {
  final DrinkModel drink;

  const DrinkDetailScreen({super.key, required this.drink});

  @override
  State<DrinkDetailScreen> createState() => _DrinkDetailScreenState();
}

class _DrinkDetailScreenState extends State<DrinkDetailScreen> {
  final _commentCtrl = TextEditingController();
  double _userRating = 5.0;

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  void _sendComment() async {
    if (_commentCtrl.text.trim().isEmpty) return;

    final user = context.read<AuthProvider>().currentUser;
    final drinkProvider = context.read<DrinkProvider>();

    final newComment = CommentModel(
      id: 'cmt_${DateTime.now().millisecondsSinceEpoch}',
      drinkId: widget.drink.id,
      drinkName: widget.drink.name,
      userId: user?.id ?? 'guest',
      userName: user?.name ?? 'Khách',
      userAvatar: user?.avatarUrl,
      content: _commentCtrl.text.trim(),
      rating: _userRating,
      isApproved: false, // Chờ duyệt
      createdAt: DateTime.now(),
    );

    await drinkProvider.addComment(newComment);
    _commentCtrl.clear();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bình luận của bạn đã được gửi và đang chờ Admin duyệt!'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drink = widget.drink;
    final drinkProvider = context.watch<DrinkProvider>();
    final comments = drinkProvider.getCommentsForDrink(drink.id);
    final catName = drinkProvider.getCategoryName(drink.categoryId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                drink.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black87, blurRadius: 8)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    drink.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(Icons.local_cafe, size: 60, color: AppColors.primary),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black26, Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meta info row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          catName,
                          style: const TextStyle(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.timer_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text('${drink.cookingTimeMinutes} phút',
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      const SizedBox(width: 12),
                      const Icon(Icons.bar_chart_outlined, size: 16, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(drink.difficulty,
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Description
                  Text(
                    drink.description,
                    style: const TextStyle(fontSize: 15, color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Ingredients Section
                  const Text(
                    'Nguyên Liệu Cần Chuẩn Bị',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: drink.ingredients.map((item) {
                        return ListTile(
                          dense: true,
                          leading: const Icon(Icons.check_circle_outline, color: AppColors.primary, size: 20),
                          title: Text(item.ingredientName, style: const TextStyle(fontWeight: FontWeight.w600)),
                          trailing: Text(
                            '${item.amount} ${item.unit}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Steps Section
                  const Text(
                    'Các Bước Thực Hiện',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 10),
                  ...drink.steps.asMap().entries.map((e) {
                    final index = e.key;
                    final step = e.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              step,
                              style: const TextStyle(fontSize: 14, height: 1.4, color: AppColors.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),

                  // Comments Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Đánh Giá & Bình Luận',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                      ),
                      Text('(${comments.length})', style: const TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Comment Input
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Đánh giá:', style: TextStyle(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 8),
                            ...List.generate(5, (starIdx) {
                              return GestureDetector(
                                onTap: () => setState(() => _userRating = starIdx + 1.0),
                                child: Icon(
                                  starIdx < _userRating ? Icons.star : Icons.star_border,
                                  color: AppColors.accent,
                                  size: 24,
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _commentCtrl,
                          decoration: InputDecoration(
                            hintText: 'Chia sẻ cảm nhận về công thức này...',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send_rounded, color: AppColors.primary),
                              onPressed: _sendComment,
                            ),
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Comments list
                  if (comments.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          'Chưa có bình luận nào được hiển thị.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    )
                  else
                    ...comments.map((c) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(c.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Row(
                                    children: List.generate(
                                      5,
                                      (idx) => Icon(
                                        idx < c.rating ? Icons.star : Icons.star_border,
                                        size: 14,
                                        color: AppColors.accent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(c.content, style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

