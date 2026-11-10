import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/models/drink_model.dart';
import '../../../l10n/app_localizations.dart';
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

  static const _preparationKeywords = [
    'rửa',
    'sơ chế',
    'gọt',
    'cắt',
    'vắt',
    'đập dập',
    'lọc bỏ bã',
    'bỏ hạt',
  ];

  static const _finishingKeywords = [
    'trang trí',
    'rắc',
    'xếp lên',
    'trình bày',
    'đặt lên trên',
  ];

  static const _brewingActionKeywords = [
    'nấu',
    'ủ',
    'chiết xuất',
    'đánh bông',
    'hòa tan',
    'khuấy',
    'rót',
    'thêm đá',
    'đun',
    'sôi',
    'pha',
    'lắc',
  ];

  static const _toolKeywords = <String, List<String>>{
    'Phin cà phê': ['phin'],
    'Bình lắc': ['bình lắc', 'lắc với đá'],
    'Ca đong': ['ca đong', 'ly đong'],
    'Dụng cụ đánh': ['cây đánh', 'đánh bông'],
    'Chày': ['chày'],
    'Nồi': ['nấu cùng'],
    'Dao': ['cắt ', 'gọt '],
    'Dụng cụ lọc': ['lọc bỏ bã', 'lọc lấy'],
  };

  bool _stepMatches(int index, List<String> keywords) {
    final step = widget.drink.steps[index].toLowerCase();
    return keywords.any(step.contains);
  }

  List<int> get _preparationStepIndexes => [
    for (var i = 0; i < widget.drink.steps.length; i++)
      if (_stepMatches(i, _preparationKeywords) &&
          !_stepMatches(i, _brewingActionKeywords) &&
          !_stepMatches(i, _finishingKeywords))
        i,
  ];

  List<int> get _finishingStepIndexes => [
    for (var i = 0; i < widget.drink.steps.length; i++)
      if (_stepMatches(i, _finishingKeywords)) i,
  ];

  List<int> get _brewingStepIndexes {
    final excludedIndexes = {
      ..._preparationStepIndexes,
      ..._finishingStepIndexes,
    };
    return [
      for (var i = 0; i < widget.drink.steps.length; i++)
        if (!excludedIndexes.contains(i)) i,
    ];
  }

  List<String> get _requiredTools {
    final recipeText = widget.drink.steps.join(' ').toLowerCase();
    final tools = <String>['Ly phục vụ'];
    for (final entry in _toolKeywords.entries) {
      if (entry.value.any(recipeText.contains)) {
        tools.add(entry.key);
      }
    }
    return tools;
  }

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

  Widget _buildGuideStepList(List<int> stepIndexes) {
    return Column(
      children: stepIndexes.map((index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${index + 1}',
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
                  widget.drink.steps[index],
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

    final l10n = AppLocalizations.of(context)!;
    final user = context.read<AuthProvider>().currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đăng nhập để bình luận.')),
      );
      return;
    }
    final drinkProvider = context.read<DrinkProvider>();

    final newComment = CommentModel(
      id: 'cmt_${DateTime.now().millisecondsSinceEpoch}',
      drinkId: widget.drink.id,
      drinkName: widget.drink.name,
      userId: user.id,
      userName: user.name.isNotEmpty ? user.name : l10n.guest,
      userAvatar: user.avatarUrl,
      content: _commentCtrl.text.trim(),
      rating: _userRating,
      isApproved: false,
      createdAt: DateTime.now(),
    );

    await drinkProvider.addComment(newComment);
    _commentCtrl.clear();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.commentSent),
        backgroundColor: AppColors.info,
      ),
    );
  }

  Future<void> _editComment(CommentModel comment) async {
    final controller = TextEditingController(text: comment.content);
    var rating = comment.rating;
    final result = await showDialog<({String content, double rating})>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Chỉnh sửa bình luận'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => IconButton(
                    tooltip: 'Đánh giá ${index + 1} sao',
                    onPressed: () => setDialogState(() => rating = index + 1.0),
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: controller,
                autofocus: true,
                maxLines: 4,
                maxLength: 500,
                decoration: const InputDecoration(
                  labelText: 'Bình luận',
                  alignLabelWithHint: true,
                ),
                onChanged: (_) => setDialogState(() {}),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: controller.text.trim().isEmpty
                  ? null
                  : () => Navigator.pop(dialogContext, (
                      content: controller.text.trim(),
                      rating: rating,
                    )),
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
    controller.dispose();

    if (result == null || !mounted) return;
    final user = context.read<AuthProvider>().currentUser;
    if (user == null) return;

    final updated = await context.read<DrinkProvider>().updateUserComment(
      commentId: comment.id,
      userId: user.id,
      content: result.content,
      rating: result.rating,
    );
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          updated
              ? 'Đã cập nhật. Bình luận đang chờ duyệt lại.'
              : 'Không thể cập nhật bình luận. Hãy thử lại.',
        ),
      ),
    );
  }

  Future<void> _deleteComment(CommentModel comment) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xóa bình luận?'),
        content: const Text('Bình luận này sẽ bị xóa khỏi công thức.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Xóa bình luận'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    final user = context.read<AuthProvider>().currentUser;
    if (user == null) return;
    final deleted = await context.read<DrinkProvider>().deleteUserComment(
      commentId: comment.id,
      userId: user.id,
    );
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          deleted
              ? 'Đã xóa bình luận.'
              : 'Không thể xóa bình luận. Hãy thử lại.',
        ),
      ),
    );
  }

  String _difficultyName(AppLocalizations l10n, String value) {
    switch (value) {
      case 'Dễ':
        return l10n.easy;
      case 'Trung bình':
        return l10n.medium;
      case 'Khó':
        return l10n.hard;
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final drink = widget.drink;
    final l10n = AppLocalizations.of(context)!;
    final drinkProvider = context.watch<DrinkProvider>();
    final currentUser = context.watch<AuthProvider>().currentUser;
    final comments = drinkProvider.comments
        .where(
          (comment) =>
              comment.drinkId == drink.id &&
              (comment.isApproved || comment.userId == currentUser?.id),
        )
        .toList();
    final catName = drinkProvider.getCategoryName(context, drink.categoryId);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            actions: const [LanguageToggleButton()],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                drink.getName(context),
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
                            l10n.minutes(drink.cookingTimeMinutes),
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
                            _difficultyName(l10n, drink.difficulty),
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
                        drink.getDescription(context),
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Ingredients Section
                      Text(
                        l10n.ingredientsTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
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
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.preparedProgress,
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
                                      value: drink.ingredients.isEmpty
                                          ? 0
                                          : _preparedIngredientIndexes.length /
                                                drink.ingredients.length,
                                      minHeight: 6,
                                      borderRadius: BorderRadius.circular(8),
                                      backgroundColor: AppColors.primaryLight,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              ...drink.ingredients.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                final isPrepared = _preparedIngredientIndexes
                                    .contains(index);

                                return Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 8,
                                    left: 12,
                                    right: 12,
                                  ),
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
                                              item.getName(context),
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
                                              '${item.amount} ${item.getUnit(context)}',
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
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Steps Section
                      Text(
                        l10n.stepsTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...drink.getSteps(context).asMap().entries.map((e) {
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
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  step,
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
                      }),
                      const SizedBox(height: 24),

                      // Comments Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.commentsTitle,
                            style: const TextStyle(
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
                                Text(
                                  l10n.ratingLabel,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
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
                                hintText: l10n.commentHint,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Text(
                              l10n.noComments,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        )
                      else
                        ...comments.map((c) {
                          final isOwnComment = currentUser?.id == c.userId;

                          return Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          c.userName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
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
                                      if (!c.isApproved)
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Chip(
                                            label: Text(
                                              'Chờ duyệt',
                                              style: TextStyle(fontSize: 11),
                                            ),
                                            visualDensity:
                                                VisualDensity.compact,
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    c.content,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  if (isOwnComment)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Wrap(
                                        spacing: 4,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () => _editComment(c),
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                              size: 18,
                                            ),
                                            label: const Text('Sửa'),
                                          ),
                                          TextButton.icon(
                                            onPressed: () => _deleteComment(c),
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              size: 18,
                                            ),
                                            label: const Text('Xóa'),
                                            style: TextButton.styleFrom(
                                              foregroundColor: AppColors.error,
                                            ),
                                          ),
                                        ],
                                      ),
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
