import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
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
    AppLocalizations l10n,
  ) {
    return Column(
      children: options.map((option) {
        final isSelected = option == selectedValue;
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(_optionLabel(option, l10n)),
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
    final l10n = AppLocalizations.of(context)!;
    final titles = [l10n.qTasteTitle, l10n.qTempTitle, l10n.qTypeTitle];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.drinkSuggestionTitle)),
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
                    l10n.questionProgress(currentStep + 1, 3),
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
                              l10n,
                            )
                          : currentStep == 1
                          ? buildOptions(
                              temperatures,
                              selectedTemperature,
                              (value) =>
                                  setState(() => selectedTemperature = value),
                              l10n,
                            )
                          : buildOptions(
                              drinkTypes,
                              selectedType,
                              (value) => setState(() => selectedType = value),
                              l10n,
                            ),
                    ),
                  ),

                  Row(
                    children: [
                      if (currentStep > 0)
                        OutlinedButton(
                          onPressed: previousStep,
                          child: Text(l10n.btnBack),
                        ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: nextStep,
                          child: Text(
                            currentStep == 2
                                ? l10n.btnGetSuggestion
                                : l10n.btnNext,
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
    final l10n = AppLocalizations.of(context)!;
    final recommendations = getRecommendedDrinks();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.yourPreferencesTitle,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          Text(l10n.prefTasteLabel(_optionLabel(selectedTaste!, l10n))),
          Text(l10n.prefTempLabel(_optionLabel(selectedTemperature!, l10n))),
          Text(l10n.prefTypeLabel(_optionLabel(selectedType!, l10n))),

          const SizedBox(height: 30),

          Text(
            l10n.matchedDrinksTitle,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          if (recommendations.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(l10n.noMatchingRecipes),
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
                  title: Text(drink.getName(context)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(drink.getDescription(context)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${drink.rating.toStringAsFixed(1)} • ${drink.getDifficulty(context)} • ${l10n.minutes(drink.cookingTimeMinutes)}',
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
              child: Text(l10n.btnRetake),
            ),
          ),
        ],
      ),
    );
  }

  String _optionLabel(String option, AppLocalizations l10n) {
    switch (option) {
      case 'Ngọt':
        return l10n.optSweet;
      case 'Chua':
        return l10n.optSour;
      case 'Đắng':
        return l10n.optBitter;
      case 'Béo':
        return l10n.optRich;
      case 'Thanh nhẹ':
        return l10n.optLight;
      case 'Nóng':
        return l10n.optHot;
      case 'Lạnh':
        return l10n.optCold;
      case 'Trà':
        return l10n.optTea;
      case 'Cà phê':
        return l10n.optCoffee;
      case 'Nước trái cây':
        return l10n.optFruitJuice;
      case 'Không quan trọng':
        return l10n.optAnyTemp;
      default:
        return option;
    }
  }
}
