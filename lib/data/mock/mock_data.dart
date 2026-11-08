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
          avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
          createdAt: DateTime(2026, 1, 1),
        ),
        UserModel(
          id: 'user_member',
          name: 'Nguyễn Văn Pha Chế',
          email: 'user@gmail.com',
          password: 'user123',
          role: 'user',
          phone: '0987654321',
          avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
          createdAt: DateTime(2026, 1, 15),
        ),
      ];

  static List<CategoryModel> get categories => [
        CategoryModel(
          id: 'cat_coffee',
          name: 'Cà phê & Bạc xỉu',
          imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=300',
          description: 'Hương vị đậm đà truyền thống và hiện đại của cà phê Việt',
        ),
        CategoryModel(
          id: 'cat_milk_tea',
          name: 'Trà sữa & Trà trái cây',
          imageUrl: 'https://images.unsplash.com/photo-1558857563-b371033873b8?w=300',
          description: 'Thanh mát, đậm đà vị trà hòa quyện trân châu dẻo thơm',
        ),
        CategoryModel(
          id: 'cat_juice',
          name: 'Nước ép & Sinh tố',
          imageUrl: 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=300',
          description: 'Giàu vitamin tươi mát tốt cho sức khỏe mỗi ngày',
        ),
        CategoryModel(
          id: 'cat_soda',
          name: 'Soda & Mocktail',
          imageUrl: 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=300',
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
      ];

  static List<CommentModel> get comments => [];
}

