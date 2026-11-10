import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../data/models/ingredient_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/drink_provider.dart';

class ManageIngredientsScreen extends StatelessWidget {
  const ManageIngredientsScreen({super.key});

  void _showIngredientDialog(
    BuildContext context, [
    IngredientModel? existing,
  ]) {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = existing != null;
    final nameCtrl = TextEditingController(
      text: existing == null ? '' : existing.getName(context),
    );
    final unitCtrl = TextEditingController(text: existing?.unit ?? 'g');
    final descCtrl = TextEditingController(
      text: existing == null ? '' : existing.getDescription(context) ?? '',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(isEditing ? l10n.editIngredient : l10n.addIngredient),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.ingredientName,
                    hintText: l10n.ingredientNameHint,
                  ),
                  validator: (val) => Validators.validateRequired(
                    val,
                    l10n.ingredientName,
                    context: context,
                    requiredMessage: l10n.valRequired,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: unitCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.unit,
                    hintText: l10n.unitHint,
                  ),
                  validator: (val) => Validators.validateRequired(
                    val,
                    l10n.unit,
                    context: context,
                    requiredMessage: l10n.valRequired,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: descCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.noteDescription,
                    hintText: l10n.descriptionHint,
                  ),
                  maxLines: 2,
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
                  unit: unitCtrl.text.trim(),
                  description: isEnglish ? null : descCtrl.text.trim(),
                  descriptionEn: isEnglish ? descCtrl.text.trim() : null,
                );
                await drinkProvider.updateIngredient(updated);
              } else {
                final newIng = IngredientModel(
                  id: 'ing_${DateTime.now().millisecondsSinceEpoch}',
                  name: nameCtrl.text.trim(),
                  nameEn: isEnglish ? nameCtrl.text.trim() : null,
                  unit: unitCtrl.text.trim(),
                  description: descCtrl.text.trim(),
                  descriptionEn: isEnglish ? descCtrl.text.trim() : null,
                );
                await drinkProvider.addIngredient(newIng);
              }
              nav.pop();
            },
            child: Text(isEditing ? l10n.update : l10n.addNew),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, IngredientModel ingredient) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmDelete),
        content: Text(l10n.deleteIngredientConfirmation(ingredient.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await context.read<DrinkProvider>().deleteIngredient(
                ingredient.id,
              );
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
    final ingredients = context.watch<DrinkProvider>().ingredients;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.manageIngredientsTitle),
        actions: const [LanguageToggleButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.secondary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          l10n.addIngredient,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () => _showIngredientDialog(context),
      ),
      body: ingredients.isEmpty
          ? Center(child: Text(l10n.noIngredients))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ing = ingredients[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.secondary.withOpacity(0.12),
                      child: const Icon(
                        Icons.kitchen_rounded,
                        color: AppColors.secondary,
                      ),
                    ),
                    title: Text(
                      ing.getName(context),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      l10n.unitLabel(ing.getUnit(context)) +
                          (ing.getDescription(context) != null
                              ? ' • ${ing.getDescription(context)}'
                              : ''),
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
                          onPressed: () => _showIngredientDialog(context, ing),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: AppColors.error,
                            size: 20,
                          ),
                          tooltip: l10n.delete,
                          onPressed: () => _confirmDelete(context, ing),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
