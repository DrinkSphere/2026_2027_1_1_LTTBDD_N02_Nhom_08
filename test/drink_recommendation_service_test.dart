import 'package:flutter_test/flutter_test.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/data/models/drink_model.dart';
import 'package:lttbdd_n02_nhom_08_2026_2027/features/user/services/drink_recommendation_service.dart';

DrinkModel _drink({
  required String id,
  required String name,
  required String categoryId,
  required String description,
  bool isApproved = true,
  double rating = 4,
}) {
  return DrinkModel(
    id: id,
    name: name,
    categoryId: categoryId,
    description: description,
    imageUrl: '',
    ingredients: [],
    steps: [],
    creatorId: 'test',
    isApproved: isApproved,
    rating: rating,
  );
}

void main() {
  final service = DrinkRecommendationService();
  final drinks = [
    _drink(
      id: 'coffee',
      name: 'Cà phê đen',
      categoryId: 'cat_coffee',
      description: 'Vị đắng đậm đà',
    ),
    _drink(
      id: 'juice',
      name: 'Nước ép cam chanh',
      categoryId: 'cat_juice',
      description: 'Vị chua tươi mát',
      rating: 4.5,
    ),
    _drink(
      id: 'tea',
      name: 'Trà sữa',
      categoryId: 'cat_milk_tea',
      description: 'Ngọt béo với sữa đặc',
      isApproved: false,
      rating: 5,
    ),
  ];

  test('ranks drinks by taste evidence and excludes unapproved recipes', () {
    final results = service.recommend(
      drinks: drinks,
      taste: 'Chua',
      temperature: 'Không quan trọng',
      type: 'Không quan trọng',
    );

    expect(results.first.drink.id, 'juice');
    expect(results.map((result) => result.drink.id), isNot(contains('tea')));
  });

  test('treats a selected drink type as a category constraint', () {
    final results = service.recommend(
      drinks: drinks,
      taste: 'Ngọt',
      temperature: 'Lạnh',
      type: 'Nước trái cây',
    );

    expect(results, hasLength(1));
    expect(results.single.drink.id, 'juice');
  });

  test('uses explicit hot or cold descriptions when ranking temperature', () {
    final results = service.recommend(
      drinks: [
        _drink(
          id: 'hot-coffee',
          name: 'Cà phê nóng',
          categoryId: 'cat_coffee',
          description: 'Vị đắng đậm đà, thưởng thức nóng',
        ),
        _drink(
          id: 'iced-coffee',
          name: 'Cà phê đá',
          categoryId: 'cat_coffee',
          description: 'Vị đắng đậm đà, uống cùng đá',
        ),
      ],
      taste: 'Đắng',
      temperature: 'Lạnh',
      type: 'Cà phê',
    );

    expect(results.first.drink.id, 'iced-coffee');
  });

  test('limits results and normalizes score when a preference is neutral', () {
    final results = service.recommend(
      drinks: drinks,
      taste: 'Đắng',
      temperature: 'Không quan trọng',
      type: 'Không quan trọng',
      limit: 1,
    );

    expect(results, hasLength(1));
    expect(results.single.drink.id, 'coffee');
    expect(results.single.score, inInclusiveRange(0, 1));
  });

  test(
    'returns no results when the requested category has no approved drinks',
    () {
      final results = service.recommend(
        drinks: drinks,
        taste: 'Ngọt',
        temperature: 'Không quan trọng',
        type: 'Trà',
      );

      expect(results, isEmpty);
    },
  );
}
