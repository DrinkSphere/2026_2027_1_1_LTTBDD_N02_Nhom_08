import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/data/models/comment_model.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/data/services/storage_service.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/providers/drink_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('users can only edit and delete their own comments', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await StorageService.getInstance();
    final comment = CommentModel(
      id: 'comment-owner',
      drinkId: 'drink-test',
      drinkName: 'Test drink',
      userId: 'user-owner',
      userName: 'Owner',
      content: 'Original comment',
      rating: 3,
      isApproved: true,
    );
    await storage.saveComments([comment]);
    final provider = DrinkProvider(storage);

    expect(
      await provider.updateUserComment(
        commentId: comment.id,
        userId: 'another-user',
        content: 'Unauthorized edit',
        rating: 1,
      ),
      isFalse,
    );
    expect(
      await provider.deleteUserComment(
        commentId: comment.id,
        userId: 'another-user',
      ),
      isFalse,
    );
    expect(provider.comments.single.content, 'Original comment');

    expect(
      await provider.updateUserComment(
        commentId: comment.id,
        userId: 'user-owner',
        content: '   ',
        rating: 5,
      ),
      isFalse,
    );
    expect(
      await provider.updateUserComment(
        commentId: comment.id,
        userId: 'user-owner',
        content: 'Invalid rating',
        rating: 6,
      ),
      isFalse,
    );

    expect(
      await provider.updateUserComment(
        commentId: comment.id,
        userId: 'user-owner',
        content: 'Updated comment',
        rating: 5,
      ),
      isTrue,
    );
    expect(provider.comments.single.content, 'Updated comment');
    expect(provider.comments.single.rating, 5);
    expect(provider.comments.single.isApproved, isFalse);
    expect(provider.getCommentsForDrink('drink-test'), isEmpty);
    expect(provider.pendingComments.single.id, comment.id);

    expect(
      await provider.deleteUserComment(
        commentId: comment.id,
        userId: 'user-owner',
      ),
      isTrue,
    );
    expect(provider.comments, isEmpty);
    expect(storage.loadComments(), isEmpty);
  });
}
