import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/comment_model.dart';
import '../../../providers/drink_provider.dart';

class ManageCommentsScreen extends StatelessWidget {
  const ManageCommentsScreen({super.key});

  void _confirmDelete(BuildContext context, CommentModel comment) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xóa bình luận'),
        content: const Text('Bạn có chắc chắn muốn xóa bình luận này không?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Hủy')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await context.read<DrinkProvider>().deleteComment(comment.id);
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drinkProvider = context.watch<DrinkProvider>();
    final comments = drinkProvider.comments;
    final pendingCount = comments.where((c) => !c.isApproved).length;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kiểm Duyệt Bình Luận'),
          bottom: TabBar(
            labelColor: AppColors.primary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Chờ duyệt'),
                    if (pendingCount > 0) ...[
                      const SizedBox(width: 6),
                      CircleAvatar(
                        radius: 9,
                        backgroundColor: AppColors.error,
                        child: Text(
                          '$pendingCount',
                          style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Tab(text: 'Tất cả bình luận'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Pending
            _buildCommentList(
              context,
              comments.where((c) => !c.isApproved).toList(),
              isPendingTab: true,
            ),
            // Tab 2: All
            _buildCommentList(context, comments, isPendingTab: false),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentList(
    BuildContext context,
    List<CommentModel> list, {
    required bool isPendingTab,
  }) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPendingTab ? Icons.check_circle_outline : Icons.chat_bubble_outline,
              size: 48,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 8),
            Text(
              isPendingTab ? 'Không có bình luận nào đang chờ duyệt' : 'Chưa có bình luận nào',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final comment = list[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primaryLight,
                          child: Text(
                            comment.userName.isNotEmpty ? comment.userName[0].toUpperCase() : 'U',
                            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comment.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text('Đồ uống: ${comment.drinkName}',
                                style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: comment.isApproved ? Colors.green.shade50 : Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        comment.isApproved ? 'Đã duyệt' : 'Chờ duyệt',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: comment.isApproved ? AppColors.success : AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(comment.content, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (starIdx) => Icon(
                          starIdx < comment.rating ? Icons.star : Icons.star_border,
                          size: 16,
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (!comment.isApproved)
                          TextButton.icon(
                            icon: const Icon(Icons.check, size: 16, color: AppColors.success),
                            label: const Text('Duyệt', style: TextStyle(color: AppColors.success)),
                            onPressed: () async {
                              await context.read<DrinkProvider>().approveComment(comment.id);
                            },
                          ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                          onPressed: () => _confirmDelete(context, comment),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

