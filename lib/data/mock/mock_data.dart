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
      nameEn: 'Coffee & Milk Coffee',
      imageUrl:
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=300',
      description: 'Hương vị đậm đà truyền thống và hiện đại của cà phê Việt',
      descriptionEn: 'Rich traditional and modern Vietnamese coffee flavors',
    ),
    CategoryModel(
      id: 'cat_milk_tea',
      name: 'Trà sữa & Trà trái cây',
      nameEn: 'Milk Tea & Fruit Tea',
      imageUrl:
          'https://images.unsplash.com/photo-1558857563-b371033873b8?w=300',
      description: 'Thanh mát, đậm đà vị trà hòa quyện trân châu dẻo thơm',
      descriptionEn: 'Refreshing tea blended with fragrant chewy boba',
    ),
    CategoryModel(
      id: 'cat_juice',
      name: 'Nước ép & Sinh tố',
      nameEn: 'Juice & Smoothie',
      imageUrl:
          'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=300',
      description: 'Giàu vitamin tươi mát tốt cho sức khỏe mỗi ngày',
      descriptionEn: 'Fresh vitamin-rich drinks for everyday wellness',
    ),
    CategoryModel(
      id: 'cat_soda',
      name: 'Soda & Mocktail',
      nameEn: 'Soda & Mocktail',
      imageUrl:
          'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=300',
      description: 'Sảng khoái bùng nổ hương vị giải nhiệt mùa hè',
      descriptionEn: 'Explosive refreshing flavors to cool down summer',
    ),
  ];

  static List<IngredientModel> get ingredients => [
    IngredientModel(
      id: 'ing_coffee',
      name: 'Cà phê Robusta nguyên chất',
      nameEn: 'Pure Robusta coffee',
      unit: 'g',
      description: 'Xay mịn vừa phải dùng pha phin',
      descriptionEn: 'Medium-fine grind suitable for Vietnamese drip coffee',
    ),
    IngredientModel(
      id: 'ing_condensed_milk',
      name: 'Sữa đặc Ông Thọ',
      nameEn: 'Ong Tho condensed milk',
      unit: 'ml',
      description: 'Tạo độ ngọt béo sánh mịn',
      descriptionEn: 'Adds smooth sweetness and richness',
    ),
    IngredientModel(
      id: 'ing_fresh_milk',
      name: 'Sữa tươi không đường',
      nameEn: 'Unsweetened fresh milk',
      unit: 'ml',
      description: 'Sữa tươi tiệt trùng thanh mát',
      descriptionEn: 'Refreshing pasteurized fresh milk',
    ),
    IngredientModel(
      id: 'ing_rich_cream',
      name: 'Kem béo thực vật (Rich lùn)',
      nameEn: 'Plant-based rich cream',
      unit: 'ml',
      description: 'Đánh bông tạo lớp màng kem muối',
      descriptionEn: 'Whip to create the salted cream layer',
    ),
    IngredientModel(
      id: 'ing_salt',
      name: 'Muối tinh hồng',
      nameEn: 'Pink fine salt',
      unit: 'g',
      description: 'Tạo vị mặn hài hòa cân bằng độ béo',
      descriptionEn: 'Balances the richness with a harmonious salty taste',
    ),
    IngredientModel(
      id: 'ing_oolong_tea',
      name: 'Trà Oolong nướng',
      nameEn: 'Roasted Oolong tea',
      unit: 'g',
      description: 'Hương thơm khói đặc trưng',
      descriptionEn: 'Distinctive roasted smoky aroma',
    ),
    IngredientModel(
      id: 'ing_boba',
      name: 'Trân châu đường đen',
      nameEn: 'Brown sugar boba',
      unit: 'g',
      description: 'Nấu dẻo ủ nước đường',
      descriptionEn: 'Cook until chewy and soak in sugar syrup',
    ),
    IngredientModel(
      id: 'ing_lime',
      name: 'Chanh không hạt',
      nameEn: 'Seedless lime',
      unit: 'quả',
      description: 'Vắt lấy cốt chanh tươi',
      descriptionEn: 'Squeeze to extract fresh lime juice',
    ),
    IngredientModel(
      id: 'ing_mint',
      name: 'Lá bạc hà tươi',
      nameEn: 'Fresh mint leaves',
      unit: 'lá',
      description: 'Rửa sạch vò nhẹ lấy hương thơm',
      descriptionEn: 'Wash and gently bruise to release the aroma',
    ),
    IngredientModel(
      id: 'ing_soda',
      name: 'Nước khoáng có ga / 7Up',
      nameEn: 'Sparkling water / 7Up',
      unit: 'lon',
      description: 'Ướp lạnh trước khi pha',
      descriptionEn: 'Chill before mixing',
    ),
    IngredientModel(
      id: 'ing_orange',
      name: 'Cam sành tươi',
      nameEn: 'Fresh orange',
      unit: 'quả',
      description: 'Vắt nước mọng ngọt tự nhiên',
      descriptionEn: 'Squeeze for naturally sweet, juicy juice',
    ),
    IngredientModel(
      id: 'ing_peach',
      name: 'Đào ngâm giòn',
      nameEn: 'Crisp preserved peach',
      unit: 'miếng',
      description: 'Cắt múi cau trang trí và ăn kèm',
      descriptionEn: 'Cut into wedges for garnish and serving',
    ),
    IngredientModel(
      id: 'ing_lemongrass',
      name: 'Sả tươi',
      nameEn: 'Fresh lemongrass',
      unit: 'cây',
      description: 'Đập dập nấu nước cốt thanh dịu',
      descriptionEn: 'Bruise and simmer to make a mild aromatic infusion',
    ),
  ];

  static List<DrinkModel> get drinks => [
    DrinkModel(
      id: 'drink_1',
      name: 'Cà Phê Muối Xứ Huế',
      nameEn: 'Hue Salt Coffee',
      categoryId: 'cat_coffee',
      description:
          'Sự hòa quyện hoàn hảo giữa vị đậm đà nguyên bản của cà phê phin cùng lớp kem mặn béo ngậy tan chảy trên đầu lưỡi.',
      descriptionEn:
          'A perfect blend of bold Vietnamese drip coffee and rich salty cream that melts on the tongue.',
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
          ingredientNameEn: 'Pure Robusta Coffee',
          amount: 25,
          unit: 'g',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_condensed_milk',
          ingredientName: 'Sữa đặc Ông Thọ',
          ingredientNameEn: 'Ong Tho Condensed Milk',
          amount: 25,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_rich_cream',
          ingredientName: 'Kem béo thực vật (Rich lùn)',
          ingredientNameEn: 'Plant-based Rich Cream',
          amount: 40,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_salt',
          ingredientName: 'Muối tinh hồng',
          ingredientNameEn: 'Pink Fine Salt',
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
      stepsEn: [
        'Put 25g of ground coffee into the filter, bloom with 20ml of boiling water for 2 minutes, then add 50ml more boiling water to extract the coffee.',
        'Add 40ml rich cream and 1g salt into a measuring cup, then whip softly for 1-2 minutes.',
        'Add 25ml condensed milk to the bottom of the glass, then fill two-thirds of the glass with ice.',
        'Slowly pour extracted coffee into the condensed milk and stir gently until evenly mixed.',
        'Gently pour the salted cream layer on top and garnish with cocoa or coffee powder.',
      ],
    ),
    DrinkModel(
      id: 'drink_bac_xiu',
      name: 'Bạc Xỉu 3 Tầng Sài Gòn',
      nameEn: 'Saigon Three-Layer Bac Xiu',
      categoryId: 'cat_coffee',
      description:
          'Món thức uống trứ danh Sài Gòn với 3 tầng đẹp mắt: sữa đặc ngọt ngào, sữa tươi thanh béo và lớp cốt cà phê phin thơm lừng trên cùng.',
      descriptionEn:
          'A famous Saigon drink with three beautiful layers of condensed milk, fresh milk, and fragrant Vietnamese drip coffee.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzR55-tXysz-Y12DmxXUwbfh4sVXRFHRELcODpIgerhA&s=10',
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
          ingredientNameEn: 'Ong Tho Condensed Milk',
          amount: 30,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_fresh_milk',
          ingredientName: 'Sữa tươi không đường',
          ingredientNameEn: 'Unsweetened Fresh Milk',
          amount: 80,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_coffee',
          ingredientName: 'Cà phê Robusta nguyên chất',
          ingredientNameEn: '100% Pure Robusta Coffee',
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
      stepsEn: [
        'Pour 30ml condensed milk into the bottom of a tall glass to create the first layer.',
        'Gently fill the glass with ice.',
        'Slowly pour 80ml unsweetened fresh milk to create the second white layer.',
        'Lightly whip 25ml Vietnamese drip coffee and pour it on top to create three perfect layers.',
      ],
    ),
    DrinkModel(
      id: 'drink_2',
      name: 'Trà Sữa Oolong Nướng Trân Châu',
      nameEn: 'Roasted Oolong Milk Tea with Boba',
      categoryId: 'cat_milk_tea',
      description:
          'Mùi thơm nướng quyến rũ đặc trưng từ lá trà Oolong tuyển chọn kết hợp trân châu đường đen dẻo dai đậm đà.',
      descriptionEn:
          'A fragrant roasted Oolong tea blended with chewy, rich brown sugar boba.',
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
          ingredientNameEn: 'Roasted Oolong Tea',
          amount: 15,
          unit: 'g',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_fresh_milk',
          ingredientName: 'Sữa tươi không đường',
          ingredientNameEn: 'Unsweetened Fresh Milk',
          amount: 100,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_condensed_milk',
          ingredientName: 'Sữa đặc Ông Thọ',
          ingredientNameEn: 'Ong Tho Condensed Milk',
          amount: 20,
          unit: 'ml',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_boba',
          ingredientName: 'Trân châu đường đen',
          ingredientNameEn: 'Brown Sugar Boba',
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
      stepsEn: [
        'Steep 15g roasted Oolong tea with 200ml of 90°C boiling water for 10 minutes, then strain to collect the fragrant tea.',
        'Dissolve condensed milk and fresh milk into the warm tea and stir evenly.',
        'Spoon 50g brown sugar boba into the bottom of a glass.',
        'Add ice and pour the Oolong milk tea into the glass. Enjoy it chilled.',
      ],
    ),
    DrinkModel(
      id: 'drink_tra_dao',
      name: 'Trà Đào Cam Sả Tươi Mát',
      nameEn: 'Refreshing Peach Orange Lemongrass Tea',
      categoryId: 'cat_milk_tea',
      description:
          'Trà trái cây thơm nức hương sả tươi, vị chua ngọt dịu từ nước cốt cam tươi cùng những miếng đào ngâm giòn ngọt mọng nước.',
      descriptionEn:
          'Fragrant fruit tea with fresh lemongrass, gently sweet orange juice, and crisp juicy peach slices.',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkzCE4HvRc5Sj3cLv-8kpzePRKWRnNFKOivjkkSpFGuA&s=10',
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
          ingredientNameEn: 'Oolong or Black Tea',
          amount: 10,
          unit: 'g',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_orange',
          ingredientName: 'Cam sành tươi',
          ingredientNameEn: 'Fresh Orange',
          amount: 1,
          unit: 'quả',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_lemongrass',
          ingredientName: 'Sả tươi',
          ingredientNameEn: 'Fresh Lemongrass',
          amount: 2,
          unit: 'cây',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_peach',
          ingredientName: 'Đào ngâm giòn',
          ingredientNameEn: 'Crisp Juicy Peach Slices',
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
      stepsEn: [
        'Bruise 2 lemongrass stalks and boil them with 250ml water, then steep the tea for 8 minutes and strain.',
        'Squeeze 40ml fresh king orange juice and mix it with 20ml sugar syrup or peach syrup.',
        'Shake the lemongrass tea and fresh orange juice with ice until evenly mixed.',
        'Pour into a glass and arrange crisp peach slices with a lemongrass stalk on top.',
      ],
    ),
    DrinkModel(
      id: 'drink_3',
      name: 'Mojito Chanh Bạc Hà Sảng Khoái',
      nameEn: 'Refreshing Lime Mint Mojito',
      categoryId: 'cat_soda',
      description:
          'Thức uống mocktail mát lạnh thanh lọc cơ thể với vị chua sảng khoái của chanh tươi và hương the mát của bạc hà.',
      descriptionEn:
          'A cool mocktail with refreshing lime and the crisp, fresh aroma of mint.',
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
          ingredientNameEn: 'Seedless Lime',
          amount: 1,
          unit: 'quả',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_mint',
          ingredientName: 'Lá bạc hà tươi',
          ingredientNameEn: 'Fresh Mint Leaves',
          amount: 8,
          unit: 'lá',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_soda',
          ingredientName: 'Nước khoáng có ga / 7Up',
          ingredientNameEn: 'Carbonated Water or 7Up',
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
      stepsEn: [
        'Cut half a lime into wedges and place it in a glass with the mint leaves.',
        'Gently muddle the lime and mint to release their fragrant oils.',
        'Add 20ml sugar syrup and fill the glass with ice.',
        'Top with soda or 7Up and garnish with fresh mint.',
      ],
    ),
    DrinkModel(
      id: 'drink_juice',
      name: 'Nước Ép Cam Cà Rốt Tươi',
      nameEn: 'Fresh Orange Carrot Juice',
      categoryId: 'cat_juice',
      description:
          'Nước ép nguyên chất dồi dào Vitamin A và C, thanh lọc cơ thể, sáng da và giải nhiệt tức thì.',
      descriptionEn:
          'A pure juice rich in vitamins A and C that refreshes, cleanses, and supports healthy skin.',
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
          ingredientNameEn: 'Fresh Orange',
          amount: 2,
          unit: 'quả',
        ),
        DrinkIngredientItem(
          ingredientId: 'ing_salt',
          ingredientName: 'Muối tinh hồng',
          ingredientNameEn: 'Pink Salt',
          amount: 0.5,
          unit: 'g',
        ),
      ],
      steps: [
        'Cam rửa sạch, vắt lấy 150ml nước cốt nguyên chất.',
        'Cà rốt gọt vỏ, ép lấy 100ml nước cốt cà rốt.',
        'Trộn đều nước cam và cà rốt, thêm chút xíu muối và đá lạnh, thưởng thức tươi mới.',
      ],
      stepsEn: [
        'Wash the oranges and squeeze 150ml of pure juice.',
        'Peel the carrots and extract 100ml of carrot juice.',
        'Mix the orange and carrot juices, add a pinch of salt and ice, then serve fresh.',
      ],
    ),
  ];

  static List<CommentModel> get comments => [];
}
