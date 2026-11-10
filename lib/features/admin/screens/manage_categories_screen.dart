import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../data/models/category_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/drink_provider.dart';
import 'manage_drinks_screen.dart';

class ManageCategoriesScreen extends StatelessWidget {
  const ManageCategoriesScreen({super.key});

  void _showCategoryDialog(BuildContext context, [CategoryModel? existing]) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = existing != null;
    final nameCtrl = TextEditingController(
      text: existing == null ? '' : existing.getName(context),
    );
    final descCtrl = TextEditingController(
      text: existing == null ? '' : existing.getDescription(context) ?? '',
    );
    final imgCtrl = TextEditingController(text: existing?.imageUrl ?? '');
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(isEditing ? l10n.editCategoryTitle : l10n.addCategory),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.categoryNameLabel,
                    hintText: l10n.categoryNameHint,
                  ),
                  validator: (val) => Validators.validateRequired(
                    val,
                    l10n.categoryNameLabel,
                    context: context,
                    requiredMessage: l10n.valRequired,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.shortDescriptionLabel,
                    hintText: l10n.categoryDescriptionHint,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: imgCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.imageUrlLabel,
                    hintText: l10n.imageUrlHint,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              final drinkProvider = context.read<DrinkProvider>();
              final nav = Navigator.of(ctx);
              final isEnglish =
                  Localizations.localeOf(context).languageCode == 'en';
              if (isEditing) {
                final updated = existing.copyWith(
                  name: isEnglish ? null : nameCtrl.text.trim(),
                  nameEn: isEnglish ? nameCtrl.text.trim() : null,
                  description: isEnglish ? null : descCtrl.text.trim(),
                  descriptionEn: isEnglish ? descCtrl.text.trim() : null,
                  imageUrl: imgCtrl.text.trim().isNotEmpty
                      ? imgCtrl.text.trim()
                      : null,
                );
                await drinkProvider.updateCategory(updated);
              } else {
                final newCat = CategoryModel(
                  id: 'cat_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameCtrl.text.trim(),
                  nameEn: isEnglish ? nameCtrl.text.trim() : null,
                  description: descCtrl.text.trim(),
                  descriptionEn: isEnglish ? descCtrl.text.trim() : null,
                  imageUrl: imgCtrl.text.trim().isNotEmpty
                      ? imgCtrl.text.trim()
                      : null,
                );
                await drinkProvider.addCategory(newCat);
              }
              nav.pop();
            },
            child: Text(isEditing ? l10n.update : l10n.addNew),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, CategoryModel category) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmDelete),
        content: Text(l10n.deleteCategoryConfirmation(category.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await context.read<DrinkProvider>().deleteCategory(category.id);
            },
            child: Text(
              l10n.delete,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final drinkProvider = context.watch<DrinkProvider>();
    final categories = drinkProvider.categories;
    final allDrinks = drinkProvider.drinks;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.manageCategoriesTitle),
        actions: const [LanguageToggleButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          l10n.addCategory,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () => _showCategoryDialog(context),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: categories.isEmpty
              ? Center(child: Text(l10n.noCategories))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final drinkCount = allDrinks
                        .where((d) => d.categoryId == cat.id)
                        .length;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        onTap: () {
                          // Bấm vào danh mục sẽ chuyển sang xem và quản lý các công thức của danh mục đó
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ManageDrinksScreen(initialCategoryId: cat.id),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(10),
                            image:
                                (cat.imageUrl != null &&
                                    cat.imageUrl!.isNotEmpty)
                                ? DecorationImage(
                                    image: NetworkImage(cat.imageUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: (cat.imageUrl == null || cat.imageUrl!.isEmpty)
                              ? const Icon(
                                  Icons.category,
                                  color: AppColors.primary,
                                )
                              : null,
                        ),
                        title: Text(
                          cat.getName(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((cat.getDescription(context) ?? '').isNotEmpty)
                              Text(
                                cat.getDescription(context)!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            const SizedBox(height: 2),
                            Text(
                              '☕ ${l10n.categorySubtitleText(drinkCount)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: AppColors.info,
                                size: 20,
                              ),
                              tooltip: l10n.editLabel,
                              onPressed: () =>
                                  _showCategoryDialog(context, cat),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: AppColors.error,
                                size: 20,
                              ),
                              tooltip: l10n.delete,
                              onPressed: () => _confirmDelete(context, cat),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
