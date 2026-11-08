import '../models/user_model.dart';
import '../models/category_model.dart';
import '../models/ingredient_model.dart';
import '../models/drink_model.dart';
import '../models/comment_model.dart';

class MockData {
  static List<UserModel> get users => [
    UserModel(
      id: 'user_admin',
      name: 'Quản trị viên Hệ thống',
      email: 'admin@gmail.com',
      password: 'admin123',
      role: 'admin',
      phone: '0901234567',
      avatarUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLDPheed3BWxk1GRFvyPmhoe0VpXhwiPE2NcGGT1w5hA&s=10',
      createdAt: DateTime(2026, 1, 1),
    ),
    UserModel(
      id: 'user_member',
      name: 'Nguyễn Văn Quế',
      email: 'user@gmail.com',
      password: 'user123',
      role: 'user',
      phone: '0987654321',
      avatarUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6Vw4DHe2j1NxYwrQBsL1ABYE8cA-ET0P8RcRyXiIDEw&s=10',
      createdAt: DateTime(2026, 1, 15),
    ),
  ];

  static List<CategoryModel> get categories => [
    CategoryModel(
      id: 'cat_coffee',
      name: 'Cà phê & Bạc xỉu',
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=300',
      description: 'Hương vị đậm đà truyền thống và hiện đại của cà phê Việt',
    ),
    CategoryModel(
      id: 'cat_milk_tea',
      name: 'Trà sữa & Trà trái cây',
      imageUrl:
          'https://images.unsplash.com/photo-1558857563-b371033873b8?w=300',
      description: 'Thanh mát, đậm đà vị trà hòa quyện trân châu dẻo thơm',
    ),
    CategoryModel(
      id: 'cat_juice',
      name: 'Nước ép & Sinh tố',
      imageUrl:
          'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=300',
      description: 'Giàu vitamin tươi mát tốt cho sức khỏe mỗi ngày',
    ),
    CategoryModel(
      id: 'cat_soda',
      name: 'Soda & Mocktail',
      imageUrl:
          'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=300',
      description: 'Sảng khoái bùng nổ hương vị giải nhiệt mùa hè',
    ),
  ];

  static List<IngredientModel> get ingredients => [
    IngredientModel(
      id: 'ing_coffee',
      name: 'Cà phê Robusta nguyên chất',
      unit: 'g',
      description: 'Xay mịn vừa phải dùng pha phin',
    ),
    IngredientModel(
      id: 'ing_condensed_milk',
      name: 'Sữa đặc Ông Thọ',
      unit: 'ml',
      description: 'Tạo độ ngọt béo sánh mịn',
    ),
    IngredientModel(
      id: 'ing_fresh_milk',
      name: 'Sữa tươi không đường',
      unit: 'ml',
      description: 'Sữa tươi tiệt trùng thanh mát',
    ),
    IngredientModel(
      id: 'ing_rich_cream',
      name: 'Kem béo thực vật (Rich lùn)',
      unit: 'ml',
      description: 'Đánh bông tạo lớp màng kem muối',
    ),
    IngredientModel(
      id: 'ing_salt',
      name: 'Muối tinh hồng',
      unit: 'g',
      description: 'Tạo vị mặn hài hòa cân bằng độ béo',
    ),
    IngredientModel(
      id: 'ing_oolong_tea',
      name: 'Trà Oolong nướng',
      unit: 'g',
      description: 'Hương thơm khói đặc trưng',
    ),
    IngredientModel(
      id: 'ing_boba',
      name: 'Trân châu đường đen',
      unit: 'g',
      description: 'Nấu dẻo ủ nước đường',
    ),
    IngredientModel(
      id: 'ing_lime',
      name: 'Chanh không hạt',
      unit: 'quả',
      description: 'Vắt lấy cốt chanh tươi',
    ),
    IngredientModel(
      id: 'ing_mint',
      name: 'Lá bạc hà tươi',
      unit: 'lá',
      description: 'Rửa sạch vò nhẹ lấy hương thơm',
    ),
    IngredientModel(
      id: 'ing_soda',
      name: 'Nước khoáng có ga / 7Up',
      unit: 'lon',
      description: 'Ướp lạnh trước khi pha',
    ),
    IngredientModel(
      id: 'ing_orange',
      name: 'Cam sành tươi',
      unit: 'quả',
      description: 'Vắt nước mọng ngọt tự nhiên',
    ),
    IngredientModel(
      id: 'ing_peach',
      name: 'Đào ngâm giòn',
      unit: 'miếng',
      description: 'Cắt múi cau trang trí và ăn kèm',
    ),
    IngredientModel(
      id: 'ing_lemongrass',
      name: 'Sả tươi',
      unit: 'cây',
      description: 'Đập dập nấu nước cốt thanh dịu',
    ),
  ];

  static List<DrinkModel> get drinks => [
    DrinkModel(
      id: 'drink_1',
      name: 'Cà Phê Muối Xứ Huế',
      categoryId: 'cat_coffee',
      description:
          'Sự hòa quyện hoàn hảo giữa vị đậm đà nguyên bản của cà phê phin cùng lớp kem mặn béo ngậy tan chảy trên đầu lưỡi.',
      imageUrl:
          'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=800',
      cookingTimeMinutes: 10,
      difficulty: 'Dễ',
      rating: 4.9,
      creatorId: 'user_admin',
      creatorName: 'Quản trị viên',
      isApproved: true,
      ingredients: [
        DrinkIngredientItem(
          ingredientId: 'ing_coffee',
          ingredientName: 'Cà phê Robusta nguyên chất',
          amount: 25,
          unit: 'g',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_condensed_milk',
          ingredientName: 'Sữa đặc Ông Thọ',
          amount: 25,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_rich_cream',
          ingredientName: 'Kem béo thực vật (Rich lùn)',
          amount: 40,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_salt',
          ingredientName: 'Muối tinh hồng',
          amount: 1,
          unit: 'g',
        ),
      ],
      steps: [
        'Cho 25g bột cà phê vào phin, ủ với 20ml nước sôi trong 2 phút rồi châm thêm 50ml nước sôi để chiết xuất cốt cà phê.',
        'Cho 40ml kem béo thực vật, 1g muối vào ca đong và dùng cây đánh bông mềm trong khoảng 1-2 phút.',
        'Cho 25ml sữa đặc vào đáy ly, thêm đá viên đầy 2/3 ly.',
        'Rót từ từ nước cốt cà phê vào ly sữa đặc, khuấy nhẹ đều màu.',
        'Rót nhẹ nhàng lớp kem muối lên trên bề mặt, rắc thêm chút bột ca cao hoặc cà phê trang trí.',
      ],
    ),
    DrinkModel(
      id: 'drink_bac_xiu',
      name: 'Bạc Xỉu 3 Tầng Sài Gòn',
      categoryId: 'cat_coffee',
      description:
          'Món thức uống trứ danh Sài Gòn với 3 tầng đẹp mắt: sữa đặc ngọt ngào, sữa tươi thanh béo và lớp cốt cà phê phin thơm lừng trên cùng.',
      imageUrl:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=800',
      cookingTimeMinutes: 8,
      difficulty: 'Dễ',
      rating: 5.0,
      creatorId: 'user_admin',
      creatorName: 'Quản trị viên',
      isApproved: true,
      ingredients: [
        DrinkIngredientItem(
          ingredientId: 'ing_condensed_milk',
          ingredientName: 'Sữa đặc Ông Thọ',
          amount: 30,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_fresh_milk',
          ingredientName: 'Sữa tươi không đường',
          amount: 80,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_coffee',
          ingredientName: 'Cà phê Robusta nguyên chất',
          amount: 25,
          unit: 'ml',
        ),
      ],
      steps: [
        'Rót 30ml sữa đặc vào đáy ly thủy tinh cao để tạo tầng thứ nhất.',
        'Thêm đầy đá viên vào ly thật nhẹ nhàng.',
        'Rót từ từ 80ml sữa tươi không đường vào để tạo tầng trắng sữa thứ hai.',
        'Đánh bông nhẹ 25ml nước cốt cà phê phin rồi rót lên trên cùng tạo thành 3 tầng hoàn hảo.',
      ],
    ),
    DrinkModel(
      id: 'drink_2',
      name: 'Trà Sữa Oolong Nướng Trân Châu',
      categoryId: 'cat_milk_tea',
      description:
          'Mùi thơm nướng quyến rũ đặc trưng từ lá trà Oolong tuyển chọn kết hợp trân châu đường đen dẻo dai đậm đà.',
      imageUrl:
          'https://images.unsplash.com/photo-1558857563-b371033873b8?w=800',
      cookingTimeMinutes: 15,
      difficulty: 'Trung bình',
      rating: 4.8,
      creatorId: 'user_admin',
      creatorName: 'Quản trị viên',
      isApproved: true,
      ingredients: [
        DrinkIngredientItem(
          ingredientId: 'ing_oolong_tea',
          ingredientName: 'Trà Oolong nướng',
          amount: 15,
          unit: 'g',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_fresh_milk',
          ingredientName: 'Sữa tươi không đường',
          amount: 100,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_condensed_milk',
          ingredientName: 'Sữa đặc Ông Thọ',
          amount: 20,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_boba',
          ingredientName: 'Trân châu đường đen',
          amount: 50,
          unit: 'g',
        ),
      ],
      steps: [
        'Ủ 15g trà Oolong nướng với 200ml nước sôi 90°C trong 10 phút, lọc bỏ bã lấy nước cốt trà thơm.',
        'Hòa tan sữa đặc và sữa tươi vào cốt trà khi còn ấm, khuấy tan đều.',
        'Múc 50g trân châu đường đen cho vào đáy ly thủy tinh.',
        'Thêm đá viên và rót trà sữa Oolong vào ly, thưởng thức ngay khi còn lạnh.',
      ],
    ),
    DrinkModel(
      id: 'drink_tra_dao',
      name: 'Trà Đào Cam Sả Tươi Mát',
      categoryId: 'cat_milk_tea',
      description:
          'Trà trái cây thơm nức hương sả tươi, vị chua ngọt dịu từ nước cốt cam tươi cùng những miếng đào ngâm giòn ngọt mọng nước.',
      imageUrl:
          'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=800',
      cookingTimeMinutes: 10,
      difficulty: 'Dễ',
      rating: 4.9,
      creatorId: 'user_admin',
      creatorName: 'Quản trị viên',
      isApproved: true,
      ingredients: [
        DrinkIngredientItem(
          ingredientId: 'ing_oolong_tea',
          ingredientName: 'Trà Oolong hoặc trà đen',
          amount: 10,
          unit: 'g',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_orange',
          ingredientName: 'Cam sành tươi',
          amount: 1,
          unit: 'quả',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_lemongrass',
          ingredientName: 'Sả tươi',
          amount: 2,
          unit: 'cây',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_peach',
          ingredientName: 'Đào ngâm giòn',
          amount: 3,
          unit: 'miếng',
        ),
      ],
      steps: [
        'Đập dập 2 cây sả nấu cùng 250ml nước sôi, sau đó cho trà vào ủ trong 8 phút rồi lọc lấy nước cốt sả trà.',
        'Vắt lấy 40ml nước cốt cam sành tươi, hòa cùng 20ml siro đường hoặc nước ngâm đào.',
        'Khuấy đều nước cốt trà sả cùng nước cam tươi trong bình lắc với đá viên.',
        'Rót ra ly, xếp các miếng đào ngâm giòn lên trên cùng cọng sả trang trí.',
      ],
    ),
    DrinkModel(
      id: 'drink_3',
      name: 'Mojito Chanh Bạc Hà Sảng Khoái',
      categoryId: 'cat_soda',
      description:
          'Thức uống mocktail mát lạnh thanh lọc cơ thể với vị chua sảng khoái của chanh tươi và hương the mát của bạc hà.',
      imageUrl:
          'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=800',
      cookingTimeMinutes: 5,
      difficulty: 'Dễ',
      rating: 4.7,
      creatorId: 'user_member',
      creatorName: 'Nguyễn Văn Pha Chế',
      isApproved: true,
      ingredients: [
        DrinkIngredientItem(
          ingredientId: 'ing_lime',
          ingredientName: 'Chanh không hạt',
          amount: 1,
          unit: 'quả',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_mint',
          ingredientName: 'Lá bạc hà tươi',
          amount: 8,
          unit: 'lá',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_soda',
          ingredientName: 'Nước khoáng có ga / 7Up',
          amount: 1,
          unit: 'lon',
        ),
      ],
      steps: [
        'Cắt nửa quả chanh thành miếng múi cau, cho vào ly cùng lá bạc hà.',
        'Dùng chày dằm nhẹ để chanh và bạc hà tiết ra tinh dầu thơm.',
        'Thêm 20ml siro đường và đổ đầy đá viên vào ly.',
        'Rót đầy soda hoặc 7up lên trên, trang trí bằng ngọn bạc hà tươi.',
      ],
    ),
    DrinkModel(
      id: 'drink_juice',
      name: 'Nước Ép Cam Cà Rốt Tươi',
      categoryId: 'cat_juice',
      description:
          'Nước ép nguyên chất dồi dào Vitamin A và C, thanh lọc cơ thể, sáng da và giải nhiệt tức thì.',
      imageUrl:
          'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=800',
      cookingTimeMinutes: 6,
      difficulty: 'Dễ',
      rating: 4.8,
      creatorId: 'user_admin',
      creatorName: 'Quản trị viên',
      isApproved: true,
      ingredients: [
        DrinkIngredientItem(
          ingredientId: 'ing_orange',
          ingredientName: 'Cam sành tươi',
          amount: 2,
          unit: 'quả',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_salt',
          ingredientName: 'Muối tinh hồng',
          amount: 0.5,
          unit: 'g',
        ),
      ],
      steps: [
        'Cam rửa sạch, vắt lấy 150ml nước cốt nguyên chất.',
        'Cà rốt gọt vỏ, ép lấy 100ml nước cốt cà rốt.',
        'Trộn đều nước cam và cà rốt, thêm chút xíu muối và đá lạnh, thưởng thức tươi mới.',
      ],
    ),
  ];

  static List<CommentModel> get comments => [];
}
