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
  final Set<int> _preparedIngredientIndexes = {};
  double _userRating = 5.0;

  void _toggleIngredient(int index) {
    setState(() {
      if (!_preparedIngredientIndexes.add(index)) {
        _preparedIngredientIndexes.remove(index);
      }
    });
  }

  Widget _buildGuideStage({
    required int number,
    required IconData icon,
    required String title,
    required String description,
    Widget? content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primary,
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(icon, color: AppColors.primaryDark, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: AppColors.textSecondary,
            ),
          ),
          if (content != null) ...[const SizedBox(height: 12), content],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DrinkDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.drink.id != widget.drink.id) {
      _preparedIngredientIndexes.clear();
    }
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
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.primaryLight,
                      child: const Icon(
                        Icons.local_cafe,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black26,
                          Colors.transparent,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Meta info row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
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
                          const Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${drink.cookingTimeMinutes} phút',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.bar_chart_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            drink.difficulty,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Description
                      Text(
                        drink.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Ingredients Section (3.2)
                      const Text(
                        'Danh Sách Nguyên Liệu',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            if (drink.ingredients.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Chưa có thông tin nguyên liệu cho món này.',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            else ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Đã chuẩn bị',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '${_preparedIngredientIndexes.length}/${drink.ingredients.length}',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value:
                                    _preparedIngredientIndexes.length /
                                    drink.ingredients.length,
                                minHeight: 6,
                                borderRadius: BorderRadius.circular(8),
                                backgroundColor: AppColors.primaryLight,
                                color: AppColors.primary,
                              ),
                              const SizedBox(height: 12),
                              ...drink.ingredients.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                final isPrepared = _preparedIngredientIndexes
                                    .contains(index);

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: isPrepared
                                        ? AppColors.primaryLight.withValues(
                                            alpha: 0.35,
                                          )
                                        : AppColors.background,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () => _toggleIngredient(index),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: isPrepared,
                                            activeColor: AppColors.primary,
                                            onChanged: (_) =>
                                                _toggleIngredient(index),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item.ingredientName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: isPrepared
                                                    ? AppColors.textSecondary
                                                    : AppColors.textPrimary,
                                                decoration: isPrepared
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(999),
                                            ),
                                            child: Text(
                                              '${item.amount} ${item.unit}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryDark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 3.3: Four-stage preparation and serving guide.
                      const Text(
                        'Hướng Dẫn Pha Chế',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildGuideStage(
                        number: 1,
                        icon: Icons.eco_outlined,
                        title: 'Sơ chế nguyên liệu',
                        description:
                            'Kiểm tra danh sách nguyên liệu phía trên, sơ chế và định lượng theo công thức.',
                      ),
                      _buildGuideStage(
                        number: 2,
                        icon: Icons.kitchen_outlined,
                        title: 'Chuẩn bị dụng cụ',
                        description:
                            'Chuẩn bị ly và các dụng cụ cần thiết cho công thức, chẳng hạn như muỗng, phin hoặc bình lắc.',
                      ),
                      _buildGuideStage(
                        number: 3,
                        icon: Icons.local_cafe_outlined,
                        title: 'Thực hiện pha chế',
                        description: drink.steps.isEmpty
                            ? 'Công thức này chưa có hướng dẫn pha chế chi tiết.'
                            : 'Thực hiện lần lượt các hướng dẫn của công thức:',
                        content: drink.steps.isEmpty
                            ? null
                            : Column(
                                children: drink.steps.asMap().entries.map((
                                  entry,
                                ) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryLight,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            '${entry.key + 1}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryDark,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            entry.value,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              height: 1.4,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      _buildGuideStage(
                        number: 4,
                        icon: Icons.auto_awesome_outlined,
                        title: 'Trang trí và hoàn thiện',
                        description:
                            'Hoàn thiện cách trình bày theo công thức; nếu có hướng dẫn trang trí, thực hiện ở bước này rồi thưởng thức.',
                      ),
                      const SizedBox(height: 24),

                      // Comments Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Đánh Giá & Bình Luận',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            '(${comments.length})',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
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
                                const Text(
                                  'Đánh giá:',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 8),
                                ...List.generate(5, (starIdx) {
                                  return GestureDetector(
                                    onTap: () => setState(
                                      () => _userRating = starIdx + 1.0,
                                    ),
                                    child: Icon(
                                      starIdx < _userRating
                                          ? Icons.star
                                          : Icons.star_border,
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
                                hintText:
                                    'Chia sẻ cảm nhận về công thức này...',
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.send_rounded,
                                    color: AppColors.primary,
                                  ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        c.userName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (idx) => Icon(
                                            idx < c.rating
                                                ? Icons.star
                                                : Icons.star_border,
                                            size: 14,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    c.content,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
