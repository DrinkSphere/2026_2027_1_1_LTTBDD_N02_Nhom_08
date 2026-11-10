import '../../../data/models/drink_model.dart';

class DrinkRecommendation {
  final DrinkModel drink;
  final double score;

  const DrinkRecommendation({required this.drink, required this.score});
}

class DrinkRecommendationService {
  static const _tasteWeight = 0.55;
  static const _typeWeight = 0.30;
  static const _temperatureWeight = 0.15;

  static const Map<String, List<String>> _tasteKeywords = {
    'Ngọt': [
      'ngọt',
      'đường',
      'siro',
      'mật ong',
      'caramel',
      'sữa đặc',
      'trân châu',
      'đào',
    ],
    'Chua': ['chua', 'chanh', 'tắc', 'cam', 'me', 'dứa', 'dâu'],
    'Đắng': [
      'đắng',
      'cà phê',
      'robusta',
      'espresso',
      'cacao',
      'matcha',
      'đậm đà',
    ],
    'Béo': ['béo', 'kem', 'sữa', 'phô mai', 'bơ', 'bạc xỉu'],
    'Thanh nhẹ': [
      'thanh',
      'tươi mát',
      'bạc hà',
      'sả',
      'nước ép',
      'giải nhiệt',
      'thanh lọc',
    ],
  };

  static const Map<String, Map<String, double>> _tasteCategoryAffinity = {
    'Ngọt': {
      'cat_milk_tea': 0.65,
      'cat_soda': 0.55,
      'cat_juice': 0.45,
      'cat_coffee': 0.35,
    },
    'Chua': {
      'cat_juice': 0.75,
      'cat_soda': 0.75,
      'cat_milk_tea': 0.45,
      'cat_coffee': 0.10,
    },
    'Đắng': {
      'cat_coffee': 0.80,
      'cat_milk_tea': 0.35,
      'cat_juice': 0.10,
      'cat_soda': 0.10,
    },
    'Béo': {
      'cat_milk_tea': 0.70,
      'cat_coffee': 0.65,
      'cat_juice': 0.15,
      'cat_soda': 0.15,
    },
    'Thanh nhẹ': {
      'cat_juice': 0.85,
      'cat_soda': 0.80,
      'cat_milk_tea': 0.50,
      'cat_coffee': 0.20,
    },
  };

  static const Map<String, String> _typeCategories = {
    'Trà': 'cat_milk_tea',
    'Cà phê': 'cat_coffee',
    'Nước trái cây': 'cat_juice',
  };

  static const Map<String, double> _coldCategoryAffinity = {
    'cat_coffee': 0.45,
    'cat_milk_tea': 0.75,
    'cat_juice': 0.95,
    'cat_soda': 0.95,
  };

  static const Map<String, double> _hotCategoryAffinity = {
    'cat_coffee': 0.75,
    'cat_milk_tea': 0.35,
    'cat_juice': 0.05,
    'cat_soda': 0.05,
  };

  List<DrinkRecommendation> recommend({
    required List<DrinkModel> drinks,
    required String taste,
    required String temperature,
    required String type,
    int limit = 3,
  }) {
    if (limit <= 0) {
      return [];
    }

    final requiredCategory = _typeCategories[type];
    final hasTypePreference =
        requiredCategory != null && type != 'Không quan trọng';
    final hasTemperaturePreference = temperature != 'Không quan trọng';
    final activeWeight =
        _tasteWeight +
        (hasTypePreference ? _typeWeight : 0) +
        (hasTemperaturePreference ? _temperatureWeight : 0);

    final recommendations = <DrinkRecommendation>[];

    for (final drink in drinks) {
      if (!drink.isApproved) {
        continue;
      }
      if (hasTypePreference && drink.categoryId != requiredCategory) {
        continue;
      }

      final tasteScore = _tasteMatchScore(drink, taste);
      final temperatureScore = hasTemperaturePreference
          ? _temperatureMatchScore(drink, temperature)
          : 0.0;
      final typeScore = hasTypePreference ? 1.0 : 0.0;

      var weightedScore = tasteScore * _tasteWeight;
      if (hasTypePreference) {
        weightedScore += typeScore * _typeWeight;
      }
      if (hasTemperaturePreference) {
        weightedScore += temperatureScore * _temperatureWeight;
      }

      recommendations.add(
        DrinkRecommendation(
          drink: drink,
          score: (weightedScore / activeWeight).clamp(0.0, 1.0),
        ),
      );
    }

    recommendations.sort((a, b) {
      final scoreComparison = b.score.compareTo(a.score);
      if (scoreComparison != 0) {
        return scoreComparison;
      }

      final ratingComparison = b.drink.rating.compareTo(a.drink.rating);
      if (ratingComparison != 0) {
        return ratingComparison;
      }
      return a.drink.name.compareTo(b.drink.name);
    });

    return recommendations.take(limit).toList();
  }

  double _tasteMatchScore(DrinkModel drink, String taste) {
    final keywords = _tasteKeywords[taste];
    if (keywords == null || keywords.isEmpty) {
      return 0;
    }

    final searchText = [
      drink.name,
      drink.description,
      ...drink.ingredients.map((ingredient) => ingredient.ingredientName),
    ].join(' ').toLowerCase();
    final matchingKeywordCount = keywords.where(searchText.contains).length;
    final keywordScore = (matchingKeywordCount / 3).clamp(0.0, 1.0);
    final categoryScore =
        _tasteCategoryAffinity[taste]?[drink.categoryId] ?? 0.0;

    return (keywordScore * 0.7 + categoryScore * 0.3).clamp(0.0, 1.0);
  }

  double _temperatureMatchScore(DrinkModel drink, String temperature) {
    final searchText = '${drink.name} ${drink.description}'.toLowerCase();
    final mentionsHot = [
      'nóng',
      'ấm nóng',
      'thưởng thức nóng',
    ].any(searchText.contains);
    final mentionsCold = [
      'lạnh',
      'đá',
      'mát',
      'giải nhiệt',
      'sảng khoái',
      'ướp lạnh',
    ].any(searchText.contains);

    if (mentionsHot != mentionsCold) {
      if (temperature == 'Nóng') {
        return mentionsHot ? 1.0 : 0.0;
      }
      if (temperature == 'Lạnh') {
        return mentionsCold ? 1.0 : 0.0;
      }
    }

    if (temperature == 'Nóng') {
      return _hotCategoryAffinity[drink.categoryId] ?? 0.25;
    }
    if (temperature == 'Lạnh') {
      return _coldCategoryAffinity[drink.categoryId] ?? 0.5;
    }
    return 0;
  }
}
