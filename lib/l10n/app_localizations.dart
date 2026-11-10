import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('vi'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'Drink Recipe App'**
  String get appName;

  /// No description provided for @languageToggle.
  ///
  /// In vi, this message translates to:
  /// **'Chuyển ngôn ngữ'**
  String get languageToggle;

  /// No description provided for @aboutTitle.
  ///
  /// In vi, this message translates to:
  /// **'Giới thiệu'**
  String get aboutTitle;

  /// No description provided for @homeTitle.
  ///
  /// In vi, this message translates to:
  /// **'Công Thức Đồ Uống'**
  String get homeTitle;

  /// No description provided for @recipesTab.
  ///
  /// In vi, this message translates to:
  /// **'Công Thức'**
  String get recipesTab;

  /// No description provided for @savedDrinksTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đồ uống đã lưu'**
  String get savedDrinksTitle;

  /// No description provided for @accountTab.
  ///
  /// In vi, this message translates to:
  /// **'Tài Khoản'**
  String get accountTab;

  /// No description provided for @searchRecipesHint.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm công thức...'**
  String get searchRecipesHint;

  /// No description provided for @allCategories.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get allCategories;

  /// No description provided for @coffeeCategory.
  ///
  /// In vi, this message translates to:
  /// **'Cà phê & Bạc xỉu'**
  String get coffeeCategory;

  /// No description provided for @milkTeaCategory.
  ///
  /// In vi, this message translates to:
  /// **'Trà sữa & Trà trái cây'**
  String get milkTeaCategory;

  /// No description provided for @juiceCategory.
  ///
  /// In vi, this message translates to:
  /// **'Nước ép & Sinh tố'**
  String get juiceCategory;

  /// No description provided for @sodaCategory.
  ///
  /// In vi, this message translates to:
  /// **'Soda & Mocktail'**
  String get sodaCategory;

  /// No description provided for @noMatchingRecipes.
  ///
  /// In vi, this message translates to:
  /// **'Không có công thức nào phù hợp.'**
  String get noMatchingRecipes;

  /// No description provided for @saveDrink.
  ///
  /// In vi, this message translates to:
  /// **'Lưu đồ uống'**
  String get saveDrink;

  /// No description provided for @unsaveDrink.
  ///
  /// In vi, this message translates to:
  /// **'Bỏ lưu đồ uống'**
  String get unsaveDrink;

  /// No description provided for @viewRecipe.
  ///
  /// In vi, this message translates to:
  /// **'Xem công thức'**
  String get viewRecipe;

  /// No description provided for @minutes.
  ///
  /// In vi, this message translates to:
  /// **'{count} phút'**
  String minutes(int count);

  /// No description provided for @easy.
  ///
  /// In vi, this message translates to:
  /// **'Dễ'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In vi, this message translates to:
  /// **'Trung bình'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In vi, this message translates to:
  /// **'Khó'**
  String get hard;

  /// No description provided for @ingredientsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Nguyên Liệu Cần Chuẩn Bị'**
  String get ingredientsTitle;

  /// No description provided for @stepsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Các Bước Thực Hiện'**
  String get stepsTitle;

  /// No description provided for @emptySavedDrinksTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có đồ uống nào được lưu'**
  String get emptySavedDrinksTitle;

  /// No description provided for @emptySavedDrinksMessage.
  ///
  /// In vi, this message translates to:
  /// **'Hãy lưu công thức yêu thích bằng biểu tượng bookmark.'**
  String get emptySavedDrinksMessage;

  /// No description provided for @profileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Hồ Sơ Cá Nhân'**
  String get profileTitle;

  /// No description provided for @userRole.
  ///
  /// In vi, this message translates to:
  /// **'THÀNH VIÊN (USER)'**
  String get userRole;

  /// No description provided for @adminRole.
  ///
  /// In vi, this message translates to:
  /// **'QUẢN TRỊ VIÊN (ADMIN)'**
  String get adminRole;

  /// No description provided for @submittedComments.
  ///
  /// In vi, this message translates to:
  /// **'Bình luận & Góp ý đã gửi'**
  String get submittedComments;

  /// No description provided for @submittedCommentsDescription.
  ///
  /// In vi, this message translates to:
  /// **'Đóng góp cảm nhận cho các công thức đồ uống'**
  String get submittedCommentsDescription;

  /// No description provided for @editProfile.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh sửa thông tin cá nhân'**
  String get editProfile;

  /// No description provided for @phone.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phone;

  /// No description provided for @joinedDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày tham gia'**
  String get joinedDate;

  /// No description provided for @logout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng Xuất Khỏi Thiết Bị'**
  String get logout;

  /// No description provided for @aboutDescription.
  ///
  /// In vi, this message translates to:
  /// **'Ứng dụng công thức đồ uống giúp bạn khám phá và lưu lại những công thức yêu thích.'**
  String get aboutDescription;

  /// No description provided for @subjectLabel.
  ///
  /// In vi, this message translates to:
  /// **'Môn học:'**
  String get subjectLabel;

  /// No description provided for @subjectValue.
  ///
  /// In vi, this message translates to:
  /// **'Lập trình thiết bị di động'**
  String get subjectValue;

  /// No description provided for @lecturerLabel.
  ///
  /// In vi, this message translates to:
  /// **'Giảng viên:'**
  String get lecturerLabel;

  /// No description provided for @lecturerValue.
  ///
  /// In vi, this message translates to:
  /// **'ThS.NCS Nguyễn Xuân Quế'**
  String get lecturerValue;

  /// No description provided for @groupLabel.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm:'**
  String get groupLabel;

  /// No description provided for @groupValue.
  ///
  /// In vi, this message translates to:
  /// **'Nhóm 8'**
  String get groupValue;

  /// No description provided for @membersLabel.
  ///
  /// In vi, this message translates to:
  /// **'Thành viên:'**
  String get membersLabel;

  /// No description provided for @membersValue.
  ///
  /// In vi, this message translates to:
  /// **'- Hồ Sỹ Long – 24100319\n- Nguyễn Lê Trung Nguyên – 24100298\n- Phan Thị Ngân Quỳnh – 24100457'**
  String get membersValue;

  /// No description provided for @commentSent.
  ///
  /// In vi, this message translates to:
  /// **'Bình luận của bạn đã được gửi và đang chờ Admin duyệt!'**
  String get commentSent;

  /// No description provided for @commentsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đánh Giá & Bình Luận'**
  String get commentsTitle;

  /// No description provided for @ratingLabel.
  ///
  /// In vi, this message translates to:
  /// **'Đánh giá:'**
  String get ratingLabel;

  /// No description provided for @commentHint.
  ///
  /// In vi, this message translates to:
  /// **'Chia sẻ cảm nhận về công thức này...'**
  String get commentHint;

  /// No description provided for @noComments.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có bình luận nào được hiển thị.'**
  String get noComments;

  /// No description provided for @systemAdministrator.
  ///
  /// In vi, this message translates to:
  /// **'Quản trị viên Hệ thống'**
  String get systemAdministrator;

  /// No description provided for @systemAdminRole.
  ///
  /// In vi, this message translates to:
  /// **'Quản trị viên Hệ thống'**
  String get systemAdminRole;

  /// No description provided for @adminDashboard.
  ///
  /// In vi, this message translates to:
  /// **'Bảng điều khiển Quản trị (Admin)'**
  String get adminDashboard;

  /// No description provided for @editProfileTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chỉnh Sửa Thông Tin'**
  String get editProfileTitle;

  /// No description provided for @fullName.
  ///
  /// In vi, this message translates to:
  /// **'Họ và tên'**
  String get fullName;

  /// No description provided for @emailAddressFixed.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ Email (Cố định)'**
  String get emailAddressFixed;

  /// No description provided for @phoneNumber.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại'**
  String get phoneNumber;

  /// No description provided for @avatarUrl.
  ///
  /// In vi, this message translates to:
  /// **'Đường dẫn ảnh đại diện (URL)'**
  String get avatarUrl;

  /// No description provided for @changePassword.
  ///
  /// In vi, this message translates to:
  /// **'Đổi mật khẩu tài khoản'**
  String get changePassword;

  /// No description provided for @saveChanges.
  ///
  /// In vi, this message translates to:
  /// **'Lưu Thay Đổi'**
  String get saveChanges;

  /// No description provided for @welcomeAdmin.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào Admin'**
  String get welcomeAdmin;

  /// No description provided for @welcomeLoginSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào {name}! Đăng nhập thành công.'**
  String welcomeLoginSuccess(String name);

  /// No description provided for @fullSystemAdministrationRights.
  ///
  /// In vi, this message translates to:
  /// **'Toàn quyền Quản trị Hệ thống'**
  String get fullSystemAdministrationRights;

  /// No description provided for @systemStatistics.
  ///
  /// In vi, this message translates to:
  /// **'Thống kê hệ thống'**
  String get systemStatistics;

  /// No description provided for @managementShortcuts.
  ///
  /// In vi, this message translates to:
  /// **'Lối tắt quản lý'**
  String get managementShortcuts;

  /// No description provided for @drinksAndRecipes.
  ///
  /// In vi, this message translates to:
  /// **'Đồ uống & Công thức'**
  String get drinksAndRecipes;

  /// No description provided for @viewEditRecipes.
  ///
  /// In vi, this message translates to:
  /// **'Xem & chỉnh sửa công thức'**
  String get viewEditRecipes;

  /// No description provided for @drinkCategories.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục đồ uống'**
  String get drinkCategories;

  /// No description provided for @menuClassification.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại thực đơn'**
  String get menuClassification;

  /// No description provided for @storageIngredients.
  ///
  /// In vi, this message translates to:
  /// **'Nguyên liệu trong kho'**
  String get storageIngredients;

  /// No description provided for @quantitiesAndUnits.
  ///
  /// In vi, this message translates to:
  /// **'Định lượng & đơn vị tính'**
  String get quantitiesAndUnits;

  /// No description provided for @pendingComments.
  ///
  /// In vi, this message translates to:
  /// **'Bình luận chờ duyệt'**
  String get pendingComments;

  /// No description provided for @allApproved.
  ///
  /// In vi, this message translates to:
  /// **'Đã duyệt tất cả'**
  String get allApproved;

  /// No description provided for @manageDrinksRecipes.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý Đồ uống & Công thức'**
  String get manageDrinksRecipes;

  /// No description provided for @addEditRecipesIngredients.
  ///
  /// In vi, this message translates to:
  /// **'Thêm, sửa công thức, định lượng nguyên liệu'**
  String get addEditRecipesIngredients;

  /// No description provided for @manageDrinkCategories.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý Danh mục đồ uống'**
  String get manageDrinkCategories;

  /// No description provided for @classifyDrinkCategories.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại cà phê, trà sữa, sinh tố, mocktail'**
  String get classifyDrinkCategories;

  /// No description provided for @manageIngredients.
  ///
  /// In vi, this message translates to:
  /// **'Quản lý Nguyên liệu'**
  String get manageIngredients;

  /// No description provided for @standardInventoryUnits.
  ///
  /// In vi, this message translates to:
  /// **'Kho nguyên liệu, đơn vị tính chuẩn'**
  String get standardInventoryUnits;

  /// No description provided for @moderateComments.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm duyệt Bình luận'**
  String get moderateComments;

  /// No description provided for @approveDeleteComments.
  ///
  /// In vi, this message translates to:
  /// **'Duyệt hoặc xóa bình luận ({count} chờ xử lý)'**
  String approveDeleteComments(int count);

  /// No description provided for @registeredUserAccounts.
  ///
  /// In vi, this message translates to:
  /// **'Hệ thống hiện có {count} tài khoản người dùng đăng ký.'**
  String registeredUserAccounts(int count);

  /// No description provided for @manageDrinksTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quản Lý Đồ Uống & Công Thức'**
  String get manageDrinksTitle;

  /// No description provided for @manageCategoriesTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quản Lý Danh Mục'**
  String get manageCategoriesTitle;

  /// No description provided for @manageIngredientsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quản Lý Nguyên Liệu'**
  String get manageIngredientsTitle;

  /// No description provided for @moderateCommentsTitle.
  ///
  /// In vi, this message translates to:
  /// **'Kiểm Duyệt Bình Luận'**
  String get moderateCommentsTitle;

  /// No description provided for @pendingTab.
  ///
  /// In vi, this message translates to:
  /// **'Chờ duyệt'**
  String get pendingTab;

  /// No description provided for @allCommentsTab.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả bình luận'**
  String get allCommentsTab;

  /// No description provided for @noPendingComments.
  ///
  /// In vi, this message translates to:
  /// **'Không có bình luận nào đang chờ duyệt'**
  String get noPendingComments;

  /// No description provided for @addDrink.
  ///
  /// In vi, this message translates to:
  /// **'Thêm Đồ Uống'**
  String get addDrink;

  /// No description provided for @addCategory.
  ///
  /// In vi, this message translates to:
  /// **'Thêm Danh Mục'**
  String get addCategory;

  /// No description provided for @addIngredient.
  ///
  /// In vi, this message translates to:
  /// **'Thêm Nguyên Liệu'**
  String get addIngredient;

  /// No description provided for @searchByNameDescription.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm theo tên hoặc mô tả...'**
  String get searchByNameDescription;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// No description provided for @update.
  ///
  /// In vi, this message translates to:
  /// **'Cập Nhật'**
  String get update;

  /// No description provided for @addNew.
  ///
  /// In vi, this message translates to:
  /// **'Thêm Mới'**
  String get addNew;

  /// No description provided for @confirmDelete.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận xóa'**
  String get confirmDelete;

  /// No description provided for @approve.
  ///
  /// In vi, this message translates to:
  /// **'Duyệt'**
  String get approve;

  /// No description provided for @allDrinksCount.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả ({count})'**
  String allDrinksCount(int count);

  /// No description provided for @noCategories.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có danh mục nào.'**
  String get noCategories;

  /// No description provided for @noIngredients.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có nguyên liệu nào.'**
  String get noIngredients;

  /// No description provided for @noPendingItems.
  ///
  /// In vi, this message translates to:
  /// **'Không có mục nào đang chờ duyệt.'**
  String get noPendingItems;

  /// No description provided for @deleteDrinkConfirmation.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa \"{name}\" khỏi hệ thống?'**
  String deleteDrinkConfirmation(Object name);

  /// No description provided for @deleteCategoryConfirmation.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc muốn xóa danh mục \"{name}\" không?'**
  String deleteCategoryConfirmation(Object name);

  /// No description provided for @deleteIngredientConfirmation.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc muốn xóa nguyên liệu \"{name}\" không?'**
  String deleteIngredientConfirmation(Object name);

  /// No description provided for @drinkManagementSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Thêm, sửa công thức, định lượng nguyên liệu'**
  String get drinkManagementSubtitle;

  /// No description provided for @categoryManagementSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Phân loại cà phê, trà sữa, sinh tố, mocktail'**
  String get categoryManagementSubtitle;

  /// No description provided for @ingredientManagementSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Kho nguyên liệu, đơn vị tính chuẩn'**
  String get ingredientManagementSubtitle;

  /// No description provided for @editIngredient.
  ///
  /// In vi, this message translates to:
  /// **'Sửa Nguyên Liệu'**
  String get editIngredient;

  /// No description provided for @ingredientName.
  ///
  /// In vi, this message translates to:
  /// **'Tên nguyên liệu'**
  String get ingredientName;

  /// No description provided for @unit.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị tính'**
  String get unit;

  /// No description provided for @noteDescription.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú / Mô tả'**
  String get noteDescription;

  /// No description provided for @updateDrink.
  ///
  /// In vi, this message translates to:
  /// **'Cập Nhật Đồ Uống'**
  String get updateDrink;

  /// No description provided for @recipeSteps.
  ///
  /// In vi, this message translates to:
  /// **'Các bước pha chế (Công thức)'**
  String get recipeSteps;

  /// No description provided for @addStep.
  ///
  /// In vi, this message translates to:
  /// **'Thêm bước'**
  String get addStep;

  /// No description provided for @chooseIngredient.
  ///
  /// In vi, this message translates to:
  /// **'Chọn nguyên liệu'**
  String get chooseIngredient;

  /// No description provided for @amount.
  ///
  /// In vi, this message translates to:
  /// **'Định lượng ({unit})'**
  String amount(Object unit);

  /// No description provided for @addIngredientToRecipe.
  ///
  /// In vi, this message translates to:
  /// **'Thêm nguyên liệu vào công thức'**
  String get addIngredientToRecipe;

  /// No description provided for @noIngredientInventory.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng tạo ít nhất một nguyên liệu trong kho trước!'**
  String get noIngredientInventory;

  /// No description provided for @atLeastOneIngredient.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng thêm ít nhất 1 nguyên liệu!'**
  String get atLeastOneIngredient;

  /// No description provided for @unitLabel.
  ///
  /// In vi, this message translates to:
  /// **'Đơn vị: {unit}'**
  String unitLabel(Object unit);

  /// No description provided for @stepPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Nhập hướng dẫn bước {number}...'**
  String stepPlaceholder(int number);

  /// No description provided for @drinkName.
  ///
  /// In vi, this message translates to:
  /// **'Tên đồ uống'**
  String get drinkName;

  /// No description provided for @drinkCategory.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục đồ uống'**
  String get drinkCategory;

  /// No description provided for @drinkDescription.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả hương vị & đặc điểm'**
  String get drinkDescription;

  /// No description provided for @drinkDescriptionHint.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả cảm quan của đồ uống...'**
  String get drinkDescriptionHint;

  /// No description provided for @imageUrl.
  ///
  /// In vi, this message translates to:
  /// **'Đường dẫn ảnh (URL)'**
  String get imageUrl;

  /// No description provided for @preparationTime.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian (phút)'**
  String get preparationTime;

  /// No description provided for @minuteUnit.
  ///
  /// In vi, this message translates to:
  /// **'phút'**
  String get minuteUnit;

  /// No description provided for @difficulty.
  ///
  /// In vi, this message translates to:
  /// **'Độ khó'**
  String get difficulty;

  /// No description provided for @ingredientsForDrink.
  ///
  /// In vi, this message translates to:
  /// **'Nguyên liệu cần dùng'**
  String get ingredientsForDrink;

  /// No description provided for @addIngredientToDrink.
  ///
  /// In vi, this message translates to:
  /// **'Thêm nguyên liệu'**
  String get addIngredientToDrink;

  /// No description provided for @noIngredientsInstruction.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có nguyên liệu nào. Bấm \"Thêm nguyên liệu\" ở trên.'**
  String get noIngredientsInstruction;

  /// No description provided for @saveDrinkRecipe.
  ///
  /// In vi, this message translates to:
  /// **'Lưu Đồ Uống & Công Thức'**
  String get saveDrinkRecipe;

  /// No description provided for @editCategoryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Sửa Danh Mục'**
  String get editCategoryTitle;

  /// No description provided for @categoryNameLabel.
  ///
  /// In vi, this message translates to:
  /// **'Tên danh mục'**
  String get categoryNameLabel;

  /// No description provided for @shortDescriptionLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả ngắn'**
  String get shortDescriptionLabel;

  /// No description provided for @categorySubtitleText.
  ///
  /// In vi, this message translates to:
  /// **'{count} công thức • Chạm để xem chi tiết →'**
  String categorySubtitleText(int count);

  /// No description provided for @ingredientStepCount.
  ///
  /// In vi, this message translates to:
  /// **'{ingredients} nguyên liệu • {steps} bước'**
  String ingredientStepCount(int ingredients, int steps);

  /// No description provided for @noDrinkRecipes.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy công thức đồ uống nào.'**
  String get noDrinkRecipes;

  /// No description provided for @viewAllCategories.
  ///
  /// In vi, this message translates to:
  /// **'Xem tất cả danh mục'**
  String get viewAllCategories;

  /// No description provided for @editRecipe.
  ///
  /// In vi, this message translates to:
  /// **'Sửa công thức'**
  String get editRecipe;

  /// No description provided for @registerTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng Ký Tài Khoản'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Khám phá vô số công thức pha chế đỉnh cao'**
  String get registerSubtitle;

  /// No description provided for @registerSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký tài khoản thành công!'**
  String get registerSuccess;

  /// No description provided for @registerFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký thất bại, vui lòng thử lại.'**
  String get registerFailed;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In vi, this message translates to:
  /// **'Quên Mật Khẩu'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Nhập email đã đăng ký để nhận liên kết khôi phục mật khẩu.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @resetPasswordSent.
  ///
  /// In vi, this message translates to:
  /// **'Liên kết khôi phục đã được gửi tới email của bạn!'**
  String get resetPasswordSent;

  /// No description provided for @resetPasswordFailed.
  ///
  /// In vi, this message translates to:
  /// **'Gửi yêu cầu thất bại, vui lòng thử lại.'**
  String get resetPasswordFailed;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản?'**
  String get alreadyHaveAccount;

  /// No description provided for @dontHaveAccount.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản?'**
  String get dontHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập ngay'**
  String get loginNow;

  /// No description provided for @registerNow.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký ngay'**
  String get registerNow;

  /// No description provided for @forgotPasswordQuestion.
  ///
  /// In vi, this message translates to:
  /// **'Quên mật khẩu?'**
  String get forgotPasswordQuestion;

  /// No description provided for @sendResetRequest.
  ///
  /// In vi, this message translates to:
  /// **'Gửi Yêu Cầu'**
  String get sendResetRequest;

  /// No description provided for @notUpdated.
  ///
  /// In vi, this message translates to:
  /// **'Chưa cập nhật'**
  String get notUpdated;

  /// No description provided for @uncategorized.
  ///
  /// In vi, this message translates to:
  /// **'Chưa phân loại'**
  String get uncategorized;

  /// No description provided for @guest.
  ///
  /// In vi, this message translates to:
  /// **'Khách'**
  String get guest;

  /// No description provided for @pendingCommentsBadge.
  ///
  /// In vi, this message translates to:
  /// **'Có bình luận cần xử lý'**
  String get pendingCommentsBadge;

  /// No description provided for @drinkLabel.
  ///
  /// In vi, this message translates to:
  /// **'Đồ uống: {name}'**
  String drinkLabel(String name);

  /// No description provided for @defaultStep1.
  ///
  /// In vi, this message translates to:
  /// **'Chuẩn bị nguyên liệu và dụng cụ pha chế.'**
  String get defaultStep1;

  /// No description provided for @defaultStep2.
  ///
  /// In vi, this message translates to:
  /// **'Tiến hành pha chế theo định lượng.'**
  String get defaultStep2;

  /// No description provided for @valRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập thông tin này'**
  String get valRequired;

  /// No description provided for @valInvalidEmail.
  ///
  /// In vi, this message translates to:
  /// **'Email không hợp lệ'**
  String get valInvalidEmail;

  /// No description provided for @valPasswordLength.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải từ 6 ký tự trở lên'**
  String get valPasswordLength;

  /// No description provided for @valPasswordMismatch.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu xác nhận không khớp'**
  String get valPasswordMismatch;

  /// No description provided for @valPhoneInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại không hợp lệ'**
  String get valPhoneInvalid;

  /// No description provided for @loginSubtitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập để quản lý công thức và pha chế'**
  String get loginSubtitle;

  /// No description provided for @quickTestAccounts.
  ///
  /// In vi, this message translates to:
  /// **'⚡ Điền nhanh tài khoản thử nghiệm:'**
  String get quickTestAccounts;

  /// No description provided for @emailLabel.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu'**
  String get passwordHint;

  /// No description provided for @registerHeading.
  ///
  /// In vi, this message translates to:
  /// **'Tạo Tài Khoản Mới'**
  String get registerHeading;

  /// No description provided for @nameHint.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: Nguyễn Văn A'**
  String get nameHint;

  /// No description provided for @emailAddressLabel.
  ///
  /// In vi, this message translates to:
  /// **'Địa chỉ Email'**
  String get emailAddressLabel;

  /// No description provided for @phoneOptionalLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại (tùy chọn)'**
  String get phoneOptionalLabel;

  /// No description provided for @passwordLengthHint.
  ///
  /// In vi, this message translates to:
  /// **'Tối thiểu 6 ký tự'**
  String get passwordLengthHint;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mật khẩu'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu vừa đặt'**
  String get confirmPasswordHint;

  /// No description provided for @newPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu mới'**
  String get newPasswordLabel;

  /// No description provided for @confirmNewPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mật khẩu mới'**
  String get confirmNewPasswordLabel;

  /// No description provided for @confirmNewPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập lại mật khẩu mới'**
  String get confirmNewPasswordHint;

  /// No description provided for @loginTitle.
  ///
  /// In vi, this message translates to:
  /// **'Đăng Nhập'**
  String get loginTitle;

  /// No description provided for @loginFailed.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập thất bại.'**
  String get loginFailed;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật thất bại.'**
  String get profileUpdateFailed;

  /// No description provided for @nameInputHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập họ và tên'**
  String get nameInputHint;

  /// No description provided for @emailReadonlyTooltip.
  ///
  /// In vi, this message translates to:
  /// **'Email dùng làm định danh, không thể thay đổi'**
  String get emailReadonlyTooltip;

  /// No description provided for @currentPasswordLabel.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu hiện tại'**
  String get currentPasswordLabel;

  /// No description provided for @currentPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Nhập mật khẩu đang dùng'**
  String get currentPasswordHint;

  /// No description provided for @newPasswordHint.
  ///
  /// In vi, this message translates to:
  /// **'Tối thiểu 6 ký tự'**
  String get newPasswordHint;

  /// No description provided for @ingredientNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: Sữa đặc Ông Thọ'**
  String get ingredientNameHint;

  /// No description provided for @unitHint.
  ///
  /// In vi, this message translates to:
  /// **'ml, g, quả, lá, muỗng...'**
  String get unitHint;

  /// No description provided for @descriptionHint.
  ///
  /// In vi, this message translates to:
  /// **'Đặc tính, cách bảo quản...'**
  String get descriptionHint;

  /// No description provided for @categoryNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: Trà trái cây'**
  String get categoryNameHint;

  /// No description provided for @categoryDescriptionHint.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả đặc trưng danh mục...'**
  String get categoryDescriptionHint;

  /// No description provided for @imageUrlLabel.
  ///
  /// In vi, this message translates to:
  /// **'Đường dẫn ảnh (URL)'**
  String get imageUrlLabel;

  /// No description provided for @imageUrlHint.
  ///
  /// In vi, this message translates to:
  /// **'https://images.unsplash.com/...'**
  String get imageUrlHint;

  /// No description provided for @drinkNameHint.
  ///
  /// In vi, this message translates to:
  /// **'Ví dụ: Cà Phê Muối Xứ Huế'**
  String get drinkNameHint;

  /// No description provided for @phoneHint.
  ///
  /// In vi, this message translates to:
  /// **'0901234567'**
  String get phoneHint;

  /// No description provided for @editLabel.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get editLabel;

  /// No description provided for @emailAlreadyRegistered.
  ///
  /// In vi, this message translates to:
  /// **'Email này đã được đăng ký trên hệ thống.'**
  String get emailAlreadyRegistered;

  /// No description provided for @invalidCredentials.
  ///
  /// In vi, this message translates to:
  /// **'Email hoặc mật khẩu không chính xác.'**
  String get invalidCredentials;

  /// No description provided for @accountNotFound.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy tài khoản.'**
  String get accountNotFound;

  /// No description provided for @currentPasswordIncorrect.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu hiện tại không chính xác.'**
  String get currentPasswordIncorrect;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
