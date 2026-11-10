import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/drink_provider.dart';
import 'drink_detail_screen.dart';
import '../services/drink_recommendation_service.dart';

class TasteRecommendationScreen extends StatefulWidget {
  const TasteRecommendationScreen({super.key});

  @override
  State<TasteRecommendationScreen> createState() =>
      _TasteRecommendationScreenState();
}

class _TasteRecommendationScreenState extends State<TasteRecommendationScreen> {
  int currentStep = 0;

  String? selectedTaste;
  String? selectedTemperature;
  String? selectedType;

  final List<String> tastes = ['Ngọt', 'Chua', 'Đắng', 'Béo', 'Thanh nhẹ'];

  final List<String> temperatures = ['Nóng', 'Lạnh', 'Không quan trọng'];

  final List<String> drinkTypes = [
    'Trà',
    'Cà phê',
    'Nước trái cây',
    'Không quan trọng',
  ];
  final _recommendationService = DrinkRecommendationService();

  void nextStep() {
    if (currentStep == 0 && selectedTaste == null) return;
    if (currentStep == 1 && selectedTemperature == null) return;
    if (currentStep == 2 && selectedType == null) return;

    setState(() {
      currentStep++;
    });
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void restart() {
    setState(() {
      currentStep = 0;
      selectedTaste = null;
      selectedTemperature = null;
      selectedType = null;
    });
  }

  List<DrinkRecommendation> getRecommendedDrinks() {
    final provider = context.read<DrinkProvider>();
    return _recommendationService.recommend(
      drinks: provider.drinks,
      taste: selectedTaste!,
      temperature: selectedTemperature!,
      type: selectedType!,
    );
  }

  Widget buildOptions(
    List<String> options,
    String? selectedValue,
    ValueChanged<String> onSelected,
  ) {
    return Column(
      children: options.map((option) {
        final isSelected = option == selectedValue;
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(option),
            leading: Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? Theme.of(context).colorScheme.primary : null,
            ),
            selected: isSelected,
            onTap: () => onSelected(option),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      'Bạn thích khẩu vị nào?',
      'Bạn thích uống nóng hay lạnh?',
      'Bạn muốn uống loại nào?',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Gợi ý đồ uống')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: currentStep == 3
            ? buildResult()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(value: (currentStep + 1) / 3),
                  const SizedBox(height: 24),

                  Text(
                    'Câu hỏi ${currentStep + 1}/3',
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    titles[currentStep],
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Expanded(
                    child: SingleChildScrollView(
                      child: currentStep == 0
                          ? buildOptions(
                              tastes,
                              selectedTaste,
                              (value) => setState(() => selectedTaste = value),
                            )
                          : currentStep == 1
                          ? buildOptions(
                              temperatures,
                              selectedTemperature,
                              (value) =>
                                  setState(() => selectedTemperature = value),
                            )
                          : buildOptions(
                              drinkTypes,
                              selectedType,
                              (value) => setState(() => selectedType = value),
                            ),
                    ),
                  ),

                  Row(
                    children: [
                      if (currentStep > 0)
                        OutlinedButton(
                          onPressed: previousStep,
                          child: const Text('Quay lại'),
                        ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: nextStep,
                          child: Text(
                            currentStep == 2 ? 'Xem gợi ý' : 'Tiếp tục',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildResult() {
    final recommendations = getRecommendedDrinks();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Khẩu vị của bạn',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Text('Khẩu vị: $selectedTaste'),
          Text('Nhiệt độ: $selectedTemperature'),
          Text('Loại đồ uống: $selectedType'),

          const SizedBox(height: 30),

          const Text(
            'Món phù hợp',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          if (recommendations.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('Hiện chưa có món nào phù hợp với lựa chọn của bạn.'),
            )
          else
            ...recommendations.map((recommendation) {
              final drink = recommendation.drink;
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      drink.imageUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 72,
                        height: 72,
                        color: Colors.orange[100],
                        child: const Icon(Icons.local_cafe),
                      ),
                    ),
                  ),
                  title: Text(drink.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(drink.description),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${drink.rating.toStringAsFixed(1)} • ${drink.difficulty} • ${drink.cookingTimeMinutes} phút',
                          ),
                        ],
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DrinkDetailScreen(drink: drink),
                      ),
                    );
                  },
                ),
              );
            }),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: restart,
              child: const Text('Chọn lại'),
            ),
          ),
        ],
      ),
    );
  }
}
