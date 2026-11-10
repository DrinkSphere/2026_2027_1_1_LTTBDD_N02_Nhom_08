// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Drink Recipe App';

  @override
  String get languageToggle => 'Chuyển ngôn ngữ';

  @override
  String get aboutTitle => 'Giới thiệu';

  @override
  String get homeTitle => 'Công Thức Đồ Uống';

  @override
  String get recipesTab => 'Công Thức';

  @override
  String get savedDrinksTitle => 'Đồ uống đã lưu';

  @override
  String get accountTab => 'Tài Khoản';

  @override
  String get searchRecipesHint => 'Tìm kiếm công thức...';

  @override
  String get allCategories => 'Tất cả';

  @override
  String get coffeeCategory => 'Cà phê & Bạc xỉu';

  @override
  String get milkTeaCategory => 'Trà sữa & Trà trái cây';

  @override
  String get juiceCategory => 'Nước ép & Sinh tố';

  @override
  String get sodaCategory => 'Soda & Mocktail';

  @override
  String get noMatchingRecipes => 'Không có công thức nào phù hợp.';

  @override
  String get saveDrink => 'Lưu đồ uống';

  @override
  String get unsaveDrink => 'Bỏ lưu đồ uống';

  @override
  String get viewRecipe => 'Xem công thức';

  @override
  String minutes(int count) {
    return '$count phút';
  }

  @override
  String get easy => 'Dễ';

  @override
  String get medium => 'Trung bình';

  @override
  String get hard => 'Khó';

  @override
  String get ingredientsTitle => 'Nguyên Liệu Cần Chuẩn Bị';

  @override
  String get stepsTitle => 'Các Bước Thực Hiện';

  @override
  String get emptySavedDrinksTitle => 'Chưa có đồ uống nào được lưu';

  @override
  String get emptySavedDrinksMessage =>
      'Hãy lưu công thức yêu thích bằng biểu tượng bookmark.';

  @override
  String get profileTitle => 'Hồ Sơ Cá Nhân';

  @override
  String get userRole => 'THÀNH VIÊN (USER)';

  @override
  String get adminRole => 'QUẢN TRỊ VIÊN (ADMIN)';

  @override
  String get submittedComments => 'Bình luận & Góp ý đã gửi';

  @override
  String get submittedCommentsDescription =>
      'Đóng góp cảm nhận cho các công thức đồ uống';

  @override
  String get editProfile => 'Chỉnh sửa thông tin cá nhân';

  @override
  String get phone => 'Số điện thoại';

  @override
  String get joinedDate => 'Ngày tham gia';

  @override
  String get logout => 'Đăng Xuất Khỏi Thiết Bị';

  @override
  String get aboutDescription =>
      'Ứng dụng công thức đồ uống giúp bạn khám phá và lưu lại những công thức yêu thích.';

  @override
  String get subjectLabel => 'Môn học:';

  @override
  String get subjectValue => 'Lập trình thiết bị di động';

  @override
  String get lecturerLabel => 'Giảng viên:';

  @override
  String get lecturerValue => 'ThS.NCS Nguyễn Xuân Quế';

  @override
  String get groupLabel => 'Nhóm:';

  @override
  String get groupValue => 'Nhóm 8';

  @override
  String get membersLabel => 'Thành viên:';

  @override
  String get membersValue =>
      '- Hồ Sỹ Long – 24100319\n- Nguyễn Lê Trung Nguyên – 24100298\n- Phan Thị Ngân Quỳnh – 24100457';

  @override
  String get commentSent =>
      'Bình luận của bạn đã được gửi và đang chờ Admin duyệt!';

  @override
  String get commentsTitle => 'Đánh Giá & Bình Luận';

  @override
  String get ratingLabel => 'Đánh giá:';

  @override
  String get commentHint => 'Chia sẻ cảm nhận về công thức này...';

  @override
  String get noComments => 'Chưa có bình luận nào được hiển thị.';

  @override
  String get systemAdministrator => 'Quản trị viên Hệ thống';

  @override
  String get systemAdminRole => 'Quản trị viên Hệ thống';

  @override
  String get adminDashboard => 'Bảng điều khiển Quản trị (Admin)';

  @override
  String get editProfileTitle => 'Chỉnh Sửa Thông Tin';

  @override
  String get fullName => 'Họ và tên';

  @override
  String get emailAddressFixed => 'Địa chỉ Email (Cố định)';

  @override
  String get phoneNumber => 'Số điện thoại';

  @override
  String get avatarUrl => 'Đường dẫn ảnh đại diện (URL)';

  @override
  String get changePassword => 'Đổi mật khẩu tài khoản';

  @override
  String get saveChanges => 'Lưu Thay Đổi';

  @override
  String get welcomeAdmin => 'Xin chào Admin';

  @override
  String welcomeLoginSuccess(String name) {
    return 'Xin chào $name! Đăng nhập thành công.';
  }

  @override
  String get fullSystemAdministrationRights => 'Toàn quyền Quản trị Hệ thống';

  @override
  String get systemStatistics => 'Thống kê hệ thống';

  @override
  String get managementShortcuts => 'Lối tắt quản lý';

  @override
  String get drinksAndRecipes => 'Đồ uống & Công thức';

  @override
  String get viewEditRecipes => 'Xem & chỉnh sửa công thức';

  @override
  String get drinkCategories => 'Danh mục đồ uống';

  @override
  String get menuClassification => 'Phân loại thực đơn';

  @override
  String get storageIngredients => 'Nguyên liệu trong kho';

  @override
  String get quantitiesAndUnits => 'Định lượng & đơn vị tính';

  @override
  String get pendingComments => 'Bình luận chờ duyệt';

  @override
  String get allApproved => 'Đã duyệt tất cả';

  @override
  String get manageDrinksRecipes => 'Quản lý Đồ uống & Công thức';

  @override
  String get addEditRecipesIngredients =>
      'Thêm, sửa công thức, định lượng nguyên liệu';

  @override
  String get manageDrinkCategories => 'Quản lý Danh mục đồ uống';

  @override
  String get classifyDrinkCategories =>
      'Phân loại cà phê, trà sữa, sinh tố, mocktail';

  @override
  String get manageIngredients => 'Quản lý Nguyên liệu';

  @override
  String get standardInventoryUnits => 'Kho nguyên liệu, đơn vị tính chuẩn';

  @override
  String get moderateComments => 'Kiểm duyệt Bình luận';

  @override
  String approveDeleteComments(int count) {
    return 'Duyệt hoặc xóa bình luận ($count chờ xử lý)';
  }

  @override
  String registeredUserAccounts(int count) {
    return 'Hệ thống hiện có $count tài khoản người dùng đăng ký.';
  }

  @override
  String get manageDrinksTitle => 'Quản Lý Đồ Uống & Công Thức';

  @override
  String get manageCategoriesTitle => 'Quản Lý Danh Mục';

  @override
  String get manageIngredientsTitle => 'Quản Lý Nguyên Liệu';

  @override
  String get moderateCommentsTitle => 'Kiểm Duyệt Bình Luận';

  @override
  String get pendingTab => 'Chờ duyệt';

  @override
  String get allCommentsTab => 'Tất cả bình luận';

  @override
  String get noPendingComments => 'Không có bình luận nào đang chờ duyệt';

  @override
  String get addDrink => 'Thêm Đồ Uống';

  @override
  String get addCategory => 'Thêm Danh Mục';

  @override
  String get addIngredient => 'Thêm Nguyên Liệu';

  @override
  String get searchByNameDescription => 'Tìm kiếm theo tên hoặc mô tả...';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get update => 'Cập Nhật';

  @override
  String get addNew => 'Thêm Mới';

  @override
  String get confirmDelete => 'Xác nhận xóa';

  @override
  String get approve => 'Duyệt';

  @override
  String allDrinksCount(int count) {
    return 'Tất cả ($count)';
  }

  @override
  String get noCategories => 'Chưa có danh mục nào.';

  @override
  String get noIngredients => 'Chưa có nguyên liệu nào.';

  @override
  String get noPendingItems => 'Không có mục nào đang chờ duyệt.';

  @override
  String deleteDrinkConfirmation(Object name) {
    return 'Bạn có chắc chắn muốn xóa \"$name\" khỏi hệ thống?';
  }

  @override
  String deleteCategoryConfirmation(Object name) {
    return 'Bạn có chắc muốn xóa danh mục \"$name\" không?';
  }

  @override
  String deleteIngredientConfirmation(Object name) {
    return 'Bạn có chắc muốn xóa nguyên liệu \"$name\" không?';
  }

  @override
  String get drinkManagementSubtitle =>
      'Thêm, sửa công thức, định lượng nguyên liệu';

  @override
  String get categoryManagementSubtitle =>
      'Phân loại cà phê, trà sữa, sinh tố, mocktail';

  @override
  String get ingredientManagementSubtitle =>
      'Kho nguyên liệu, đơn vị tính chuẩn';

  @override
  String get editIngredient => 'Sửa Nguyên Liệu';

  @override
  String get ingredientName => 'Tên nguyên liệu';

  @override
  String get unit => 'Đơn vị tính';

  @override
  String get noteDescription => 'Ghi chú / Mô tả';

  @override
  String get updateDrink => 'Cập Nhật Đồ Uống';

  @override
  String get recipeSteps => 'Các bước pha chế (Công thức)';

  @override
  String get addStep => 'Thêm bước';

  @override
  String get chooseIngredient => 'Chọn nguyên liệu';

  @override
  String amount(Object unit) {
    return 'Định lượng ($unit)';
  }

  @override
  String get addIngredientToRecipe => 'Thêm nguyên liệu vào công thức';

  @override
  String get noIngredientInventory =>
      'Vui lòng tạo ít nhất một nguyên liệu trong kho trước!';

  @override
  String get atLeastOneIngredient => 'Vui lòng thêm ít nhất 1 nguyên liệu!';

  @override
  String unitLabel(Object unit) {
    return 'Đơn vị: $unit';
  }

  @override
  String stepPlaceholder(int number) {
    return 'Nhập hướng dẫn bước $number...';
  }

  @override
  String get drinkName => 'Tên đồ uống';

  @override
  String get drinkCategory => 'Danh mục đồ uống';

  @override
  String get drinkDescription => 'Mô tả hương vị & đặc điểm';

  @override
  String get drinkDescriptionHint => 'Mô tả cảm quan của đồ uống...';

  @override
  String get imageUrl => 'Đường dẫn ảnh (URL)';

  @override
  String get preparationTime => 'Thời gian (phút)';

  @override
  String get minuteUnit => 'phút';

  @override
  String get difficulty => 'Độ khó';

  @override
  String get ingredientsForDrink => 'Nguyên liệu cần dùng';

  @override
  String get addIngredientToDrink => 'Thêm nguyên liệu';

  @override
  String get noIngredientsInstruction =>
      'Chưa có nguyên liệu nào. Bấm \"Thêm nguyên liệu\" ở trên.';

  @override
  String get saveDrinkRecipe => 'Lưu Đồ Uống & Công Thức';

  @override
  String get editCategoryTitle => 'Sửa Danh Mục';

  @override
  String get categoryNameLabel => 'Tên danh mục';

  @override
  String get shortDescriptionLabel => 'Mô tả ngắn';

  @override
  String categorySubtitleText(int count) {
    return '$count công thức • Chạm để xem chi tiết →';
  }

  @override
  String ingredientStepCount(int ingredients, int steps) {
    return '$ingredients nguyên liệu • $steps bước';
  }

  @override
  String get noDrinkRecipes => 'Không tìm thấy công thức đồ uống nào.';

  @override
  String get viewAllCategories => 'Xem tất cả danh mục';

  @override
  String get editRecipe => 'Sửa công thức';

  @override
  String get registerTitle => 'Đăng Ký Tài Khoản';

  @override
  String get registerSubtitle => 'Khám phá vô số công thức pha chế đỉnh cao';

  @override
  String get registerSuccess => 'Đăng ký tài khoản thành công!';

  @override
  String get registerFailed => 'Đăng ký thất bại, vui lòng thử lại.';

  @override
  String get forgotPasswordTitle => 'Quên Mật Khẩu';

  @override
  String get forgotPasswordSubtitle =>
      'Nhập email đã đăng ký để nhận liên kết khôi phục mật khẩu.';

  @override
  String get resetPasswordSent =>
      'Liên kết khôi phục đã được gửi tới email của bạn!';

  @override
  String get resetPasswordFailed => 'Gửi yêu cầu thất bại, vui lòng thử lại.';

  @override
  String get alreadyHaveAccount => 'Đã có tài khoản?';

  @override
  String get dontHaveAccount => 'Chưa có tài khoản?';

  @override
  String get loginNow => 'Đăng nhập ngay';

  @override
  String get registerNow => 'Đăng ký ngay';

  @override
  String get forgotPasswordQuestion => 'Quên mật khẩu?';

  @override
  String get sendResetRequest => 'Gửi Yêu Cầu';

  @override
  String get notUpdated => 'Chưa cập nhật';

  @override
  String get uncategorized => 'Chưa phân loại';

  @override
  String get guest => 'Khách';

  @override
  String get pendingCommentsBadge => 'Có bình luận cần xử lý';

  @override
  String drinkLabel(String name) {
    return 'Đồ uống: $name';
  }

  @override
  String get defaultStep1 => 'Chuẩn bị nguyên liệu và dụng cụ pha chế.';

  @override
  String get defaultStep2 => 'Tiến hành pha chế theo định lượng.';

  @override
  String get valRequired => 'Vui lòng nhập thông tin này';

  @override
  String get valInvalidEmail => 'Email không hợp lệ';

  @override
  String get valPasswordLength => 'Mật khẩu phải từ 6 ký tự trở lên';

  @override
  String get valPasswordMismatch => 'Mật khẩu xác nhận không khớp';

  @override
  String get valPhoneInvalid => 'Số điện thoại không hợp lệ';

  @override
  String get loginSubtitle => 'Đăng nhập để quản lý công thức và pha chế';

  @override
  String get quickTestAccounts => '⚡ Điền nhanh tài khoản thử nghiệm:';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get passwordHint => 'Nhập mật khẩu';

  @override
  String get registerHeading => 'Tạo Tài Khoản Mới';

  @override
  String get nameHint => 'Ví dụ: Nguyễn Văn A';

  @override
  String get emailAddressLabel => 'Địa chỉ Email';

  @override
  String get phoneOptionalLabel => 'Số điện thoại (tùy chọn)';

  @override
  String get passwordLengthHint => 'Tối thiểu 6 ký tự';

  @override
  String get confirmPasswordLabel => 'Xác nhận mật khẩu';

  @override
  String get confirmPasswordHint => 'Nhập lại mật khẩu vừa đặt';

  @override
  String get newPasswordLabel => 'Mật khẩu mới';

  @override
  String get confirmNewPasswordLabel => 'Xác nhận mật khẩu mới';

  @override
  String get confirmNewPasswordHint => 'Nhập lại mật khẩu mới';

  @override
  String get loginTitle => 'Đăng Nhập';

  @override
  String get loginFailed => 'Đăng nhập thất bại.';

  @override
  String get profileUpdateFailed => 'Cập nhật thất bại.';

  @override
  String get nameInputHint => 'Nhập họ và tên';

  @override
  String get emailReadonlyTooltip =>
      'Email dùng làm định danh, không thể thay đổi';

  @override
  String get currentPasswordLabel => 'Mật khẩu hiện tại';

  @override
  String get currentPasswordHint => 'Nhập mật khẩu đang dùng';

  @override
  String get newPasswordHint => 'Tối thiểu 6 ký tự';

  @override
  String get ingredientNameHint => 'Ví dụ: Sữa đặc Ông Thọ';

  @override
  String get unitHint => 'ml, g, quả, lá, muỗng...';

  @override
  String get descriptionHint => 'Đặc tính, cách bảo quản...';

  @override
  String get categoryNameHint => 'Ví dụ: Trà trái cây';

  @override
  String get categoryDescriptionHint => 'Mô tả đặc trưng danh mục...';

  @override
  String get imageUrlLabel => 'Đường dẫn ảnh (URL)';

  @override
  String get imageUrlHint => 'https://images.unsplash.com/...';

  @override
  String get drinkNameHint => 'Ví dụ: Cà Phê Muối Xứ Huế';

  @override
  String get phoneHint => '0901234567';

  @override
  String get editLabel => 'Sửa';

  @override
  String get emailAlreadyRegistered =>
      'Email này đã được đăng ký trên hệ thống.';

  @override
  String get invalidCredentials => 'Email hoặc mật khẩu không chính xác.';

  @override
  String get accountNotFound => 'Không tìm thấy tài khoản.';

  @override
  String get currentPasswordIncorrect => 'Mật khẩu hiện tại không chính xác.';
}
