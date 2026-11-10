import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../data/models/drink_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/drink_provider.dart';

class DrinkFormScreen extends StatefulWidget {
  final DrinkModel? initialDrink;

  const DrinkFormScreen({super.key, this.initialDrink});

  @override
  State<DrinkFormScreen> createState() => _DrinkFormScreenState();
}

class _DrinkFormScreenState extends State<DrinkFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _imgCtrl;
  late final TextEditingController _timeCtrl;

  late String _selectedCategoryId;
  late String _selectedDifficulty;

  late List<DrinkIngredientItem> _selectedIngredients;
  late List<TextEditingController> _stepControllers;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final d = widget.initialDrink;
    final drinkProvider = context.read<DrinkProvider>();
    final l10n = AppLocalizations.of(context)!;

    _nameCtrl = TextEditingController(text: d?.name ?? '');
    _descCtrl = TextEditingController(text: d?.description ?? '');
    _imgCtrl = TextEditingController(
      text:
          d?.imageUrl ??
          'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=500',
    );
    _timeCtrl = TextEditingController(
      text: (d?.cookingTimeMinutes ?? 10).toString(),
    );

    _selectedCategoryId =
        d?.categoryId ??
        (drinkProvider.categories.isNotEmpty
            ? drinkProvider.categories.first.id
            : '');
    _selectedDifficulty = d?.difficulty ?? 'Dễ';

    _selectedIngredients =
        d?.ingredients
            .map(
              (e) => DrinkIngredientItem(
                ingredientId: e.ingredientId,
                ingredientName: e.ingredientName,
                ingredientNameEn: e.ingredientNameEn,
                amount: e.amount,
                unit: e.unit,
              ),
            )
            .toList() ??
        [];

    if (d != null && d.steps.isNotEmpty) {
      _stepControllers = d.steps
          .map((s) => TextEditingController(text: s))
          .toList();
    } else {
      _stepControllers = [
        TextEditingController(text: l10n.defaultStep1),
        TextEditingController(text: l10n.defaultStep2),
      ];
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _imgCtrl.dispose();
    _timeCtrl.dispose();
    for (var c in _stepControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addIngredientDialog() {
    final l10n = AppLocalizations.of(context)!;
    final drinkProvider = context.read<DrinkProvider>();
    final allIngredients = drinkProvider.ingredients;

    if (allIngredients.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.noIngredientInventory)));
      return;
    }

    String chosenIngId = allIngredients.first.id;
    final amountCtrl = TextEditingController(text: '10');

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) {
          final currentIng = allIngredients.firstWhere(
            (i) => i.id == chosenIngId,
          );
          return AlertDialog(
            title: Text(l10n.addIngredientToRecipe),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: chosenIngId,
                  decoration: InputDecoration(labelText: l10n.chooseIngredient),
                  items: allIngredients.map((i) {
                    return DropdownMenuItem(
                      value: i.id,
                      child: Text(i.getName(context)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setDlgState(() {
                        chosenIngId = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: amountCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: l10n.amount(currentIng.unit),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(l10n.cancel),
              ),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text) ?? 10.0;
                  setState(() {
                    _selectedIngredients.add(
                      DrinkIngredientItem(
                        ingredientId: currentIng.id,
                        ingredientName: currentIng.name,
                        amount: amount,
                        unit: currentIng.unit,
                      ),
                    );
                  });
                  Navigator.of(ctx).pop();
                },
                child: Text(l10n.addNew),
              ),
            ],
          );
        },
      ),
    );
  }

  void _saveDrink() async {
    final l10n = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.atLeastOneIngredient)));
      return;
    }

    final drinkProvider = context.read<DrinkProvider>();
    final currentUser = context.read<AuthProvider>().currentUser;
    final isEditing = widget.initialDrink != null;

    final steps = _stepControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final drink = DrinkModel(
      id: isEditing
          ? widget.initialDrink!.id
          : 'drink_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameCtrl.text.trim(),
      categoryId: _selectedCategoryId,
      description: _descCtrl.text.trim(),
      imageUrl: _imgCtrl.text.trim(),
      cookingTimeMinutes: int.tryParse(_timeCtrl.text) ?? 10,
      difficulty: _selectedDifficulty,
      ingredients: _selectedIngredients,
      steps: steps.isNotEmpty ? steps : [l10n.defaultStep1],
      creatorId: isEditing
          ? widget.initialDrink!.creatorId
          : (currentUser?.id ?? 'admin'),
      creatorName: isEditing
          ? widget.initialDrink!.creatorName
          : (currentUser?.name ?? 'Admin'),
      rating: isEditing ? widget.initialDrink!.rating : 5.0,
      isApproved: true,
    );

    if (isEditing) {
      await drinkProvider.updateDrink(drink);
    } else {
      await drinkProvider.addDrink(drink);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<DrinkProvider>().categories;
    final isEditing = widget.initialDrink != null;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.updateDrink : l10n.addDrink),
        actions: [
          const LanguageToggleButton(),
          IconButton(
            icon: const Icon(Icons.check, color: AppColors.primary),
            onPressed: _saveDrink,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tên đồ uống
            TextFormField(
              controller: _nameCtrl,
              decoration: InputDecoration(
                labelText: l10n.drinkName,
                hintText: l10n.drinkNameHint,
              ),
              validator: (val) => Validators.validateRequired(
                val,
                l10n.drinkName,
                context: context,
                requiredMessage: l10n.valRequired,
              ),
            ),
            const SizedBox(height: 14),

            // Danh mục
            DropdownButtonFormField<String>(
              value: _selectedCategoryId.isNotEmpty
                  ? _selectedCategoryId
                  : null,
              decoration: InputDecoration(labelText: l10n.drinkCategory),
              items: categories.map((c) {
                return DropdownMenuItem(
                  value: c.id,
                  child: Text(c.getName(context)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategoryId = val);
              },
            ),
            const SizedBox(height: 14),

            // Mô tả
            TextFormField(
              controller: _descCtrl,
              decoration: InputDecoration(
                labelText: l10n.drinkDescription,
                hintText: l10n.drinkDescriptionHint,
              ),
              maxLines: 2,
              validator: (val) => Validators.validateRequired(
                val,
                l10n.drinkDescription,
                context: context,
                requiredMessage: l10n.valRequired,
              ),
            ),
            const SizedBox(height: 14),

            // Ảnh URL
            TextFormField(
              controller: _imgCtrl,
              decoration: InputDecoration(
                labelText: l10n.imageUrl,
                hintText: l10n.imageUrlHint,
              ),
            ),
            const SizedBox(height: 14),

            // Thời gian & Độ khó
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _timeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: l10n.preparationTime,
                      suffixText: l10n.minuteUnit,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDifficulty,
                    decoration: InputDecoration(labelText: l10n.difficulty),
                    items: [
                      DropdownMenuItem(value: 'Dễ', child: Text(l10n.easy)),
                      DropdownMenuItem(
                        value: 'Trung bình',
                        child: Text(l10n.medium),
                      ),
                      DropdownMenuItem(value: 'Khó', child: Text(l10n.hard)),
                    ],
                    onChanged: (val) {
                      if (val != null)
                        setState(() => _selectedDifficulty = val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Phần nguyên liệu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.ingredientsForDrink,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _addIngredientDialog,
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.addIngredientToDrink),
                ),
              ],
            ),
            if (_selectedIngredients.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  l10n.noIngredientsInstruction,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            else
              ..._selectedIngredients.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.primary,
                    ),
                    title: Text(
                      item.getName(context),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('${item.amount} ${item.getUnit(context)}'),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: AppColors.error,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedIngredients.removeAt(idx);
                        });
                      },
                    ),
                  ),
                );
              }),
            const SizedBox(height: 20),

            // Phần các bước thực hiện
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.recipeSteps,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _stepControllers.add(TextEditingController());
                    });
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(l10n.addStep),
                ),
              ],
            ),
            ..._stepControllers.asMap().entries.map((entry) {
              final idx = entry.key;
              final ctrl = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        '${idx + 1}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: ctrl,
                        decoration: InputDecoration(
                          hintText: l10n.stepPlaceholder(idx + 1),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    if (_stepControllers.length > 1)
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                        ),
                        onPressed: () {
                          setState(() {
                            _stepControllers.removeAt(idx);
                          });
                        },
                      ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 30),

            // Nút Lưu
            ElevatedButton(
              onPressed: _saveDrink,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                isEditing ? l10n.updateDrink : l10n.saveDrinkRecipe,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
