import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../data/models/drink_model.dart';
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

  @override
  void initState() {
    super.initState();
    final d = widget.initialDrink;
    final drinkProvider = context.read<DrinkProvider>();

    _nameCtrl = TextEditingController(text: d?.name ?? '');
    _descCtrl = TextEditingController(text: d?.description ?? '');
    _imgCtrl = TextEditingController(
      text: d?.imageUrl ?? 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=500',
    );
    _timeCtrl = TextEditingController(text: (d?.cookingTimeMinutes ?? 10).toString());

    _selectedCategoryId = d?.categoryId ??
        (drinkProvider.categories.isNotEmpty ? drinkProvider.categories.first.id : '');
    _selectedDifficulty = d?.difficulty ?? 'Dễ';

    _selectedIngredients = d?.ingredients.map((e) => DrinkIngredientItem(
          ingredientId: e.ingredientId,
          ingredientName: e.ingredientName,
          amount: e.amount,
          unit: e.unit,
        )).toList() ?? [];

    if (d != null && d.steps.isNotEmpty) {
      _stepControllers = d.steps.map((s) => TextEditingController(text: s)).toList();
    } else {
      _stepControllers = [
        TextEditingController(text: 'Chuẩn bị nguyên liệu sạch sẽ.'),
        TextEditingController(text: 'Tiến hành pha chế theo định lượng.'),
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
    final drinkProvider = context.read<DrinkProvider>();
    final allIngredients = drinkProvider.ingredients;

    if (allIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng tạo ít nhất một nguyên liệu trong kho trước!')),
      );
      return;
    }

    String chosenIngId = allIngredients.first.id;
    final amountCtrl = TextEditingController(text: '10');

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDlgState) {
          final currentIng = allIngredients.firstWhere((i) => i.id == chosenIngId);
          return AlertDialog(
            title: const Text('Thêm nguyên liệu vào công thức'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: chosenIngId,
                  decoration: const InputDecoration(labelText: 'Chọn nguyên liệu'),
                  items: allIngredients.map((i) {
                    return DropdownMenuItem(value: i.id, child: Text(i.name));
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
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Định lượng (${currentIng.unit})',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Hủy')),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(amountCtrl.text) ?? 10.0;
                  setState(() {
                    _selectedIngredients.add(DrinkIngredientItem(
                      ingredientId: currentIng.id,
                      ingredientName: currentIng.name,
                      amount: amount,
                      unit: currentIng.unit,
                    ));
                  });
                  Navigator.of(ctx).pop();
                },
                child: const Text('Thêm'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _saveDrink() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng thêm ít nhất 1 nguyên liệu!')),
      );
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
      id: isEditing ? widget.initialDrink!.id : 'drink_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameCtrl.text.trim(),
      categoryId: _selectedCategoryId,
      description: _descCtrl.text.trim(),
      imageUrl: _imgCtrl.text.trim(),
      cookingTimeMinutes: int.tryParse(_timeCtrl.text) ?? 10,
      difficulty: _selectedDifficulty,
      ingredients: _selectedIngredients,
      steps: steps.isNotEmpty ? steps : ['Thực hiện pha chế theo công thức.'],
      creatorId: isEditing ? widget.initialDrink!.creatorId : (currentUser?.id ?? 'admin'),
      creatorName: isEditing ? widget.initialDrink!.creatorName : (currentUser?.name ?? 'Admin'),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Cập Nhật Đồ Uống' : 'Thêm Đồ Uống & Công Thức'),
        actions: [
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
              decoration: const InputDecoration(
                labelText: 'Tên đồ uống',
                hintText: 'Ví dụ: Cà Phê Muối Xứ Huế',
              ),
              validator: (val) => Validators.validateRequired(val, 'tên đồ uống'),
            ),
            const SizedBox(height: 14),

            // Danh mục
            DropdownButtonFormField<String>(
              value: _selectedCategoryId.isNotEmpty ? _selectedCategoryId : null,
              decoration: const InputDecoration(labelText: 'Danh mục đồ uống'),
              items: categories.map((c) {
                return DropdownMenuItem(value: c.id, child: Text(c.name));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategoryId = val);
              },
            ),
            const SizedBox(height: 14),

            // Mô tả
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Mô tả hương vị & đặc điểm',
                hintText: 'Mô tả cảm quan của đồ uống...',
              ),
              maxLines: 2,
              validator: (val) => Validators.validateRequired(val, 'mô tả đồ uống'),
            ),
            const SizedBox(height: 14),

            // Ảnh URL
            TextFormField(
              controller: _imgCtrl,
              decoration: const InputDecoration(
                labelText: 'Đường dẫn ảnh (URL)',
                hintText: 'https://...',
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
                    decoration: const InputDecoration(
                      labelText: 'Thời gian (phút)',
                      suffixText: 'phút',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDifficulty,
                    decoration: const InputDecoration(labelText: 'Độ khó'),
                    items: const [
                      DropdownMenuItem(value: 'Dễ', child: Text('Dễ')),
                      DropdownMenuItem(value: 'Trung bình', child: Text('Trung bình')),
                      DropdownMenuItem(value: 'Khó', child: Text('Khó')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedDifficulty = val);
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
                const Text(
                  'Nguyên liệu cần dùng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _addIngredientDialog,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Thêm nguyên liệu'),
                ),
              ],
            ),
            if (_selectedIngredients.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text('Chưa có nguyên liệu nào. Bấm "Thêm nguyên liệu" ở trên.',
                    style: TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
              )
            else
              ..._selectedIngredients.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    dense: true,
                    leading: const Icon(Icons.check_circle_outline, color: AppColors.primary),
                    title: Text(item.ingredientName, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('${item.amount} ${item.unit}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: AppColors.error, size: 20),
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
                const Text(
                  'Các bước pha chế (Công thức)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _stepControllers.add(TextEditingController());
                    });
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Thêm bước'),
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
                        style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: ctrl,
                        decoration: InputDecoration(
                          hintText: 'Nhập hướng dẫn bước ${idx + 1}...',
                        ),
                        maxLines: 2,
                      ),
                    ),
                    if (_stepControllers.length > 1)
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.error),
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
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: Text(
                isEditing ? 'Cập Nhật Đồ Uống' : 'Lưu Đồ Uống & Công Thức',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

