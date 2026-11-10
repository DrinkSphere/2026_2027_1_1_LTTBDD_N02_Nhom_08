// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Drink Recipe App';

  @override
  String get languageToggle => 'Change language';

  @override
  String get aboutTitle => 'About';

  @override
  String get homeTitle => 'Drink Recipes';

  @override
  String get recipesTab => 'Recipes';

  @override
  String get savedDrinksTitle => 'Saved Drinks';

  @override
  String get accountTab => 'Profile';

  @override
  String get searchRecipesHint => 'Search recipes...';

  @override
  String get allCategories => 'All';

  @override
  String get coffeeCategory => 'Coffee & Milk Coffee';

  @override
  String get milkTeaCategory => 'Milk Tea & Fruit Tea';

  @override
  String get juiceCategory => 'Juice & Smoothie';

  @override
  String get sodaCategory => 'Soda & Mocktail';

  @override
  String get noMatchingRecipes => 'No matching recipes found.';

  @override
  String get saveDrink => 'Save drink';

  @override
  String get unsaveDrink => 'Remove saved drink';

  @override
  String get viewRecipe => 'View recipe';

  @override
  String get suggestionBannerTitle => 'Not sure what to drink?';

  @override
  String get suggestionBannerSubtitle => 'Drink recommendation quiz for you';

  @override
  String get viewRecipeArrow => 'View recipe →';

  @override
  String get drinkSuggestionTitle => 'Drink Recommendations';

  @override
  String questionProgress(int current, int total) {
    return 'Question $current/$total';
  }

  @override
  String get qTasteTitle => 'Which flavor do you prefer?';

  @override
  String get optSweet => 'Sweet';

  @override
  String get optSour => 'Sour';

  @override
  String get optBitter => 'Bitter';

  @override
  String get optRich => 'Rich & Creamy';

  @override
  String get optLight => 'Light & Refreshing';

  @override
  String get qTempTitle => 'Do you prefer hot or cold drinks?';

  @override
  String get optHot => 'Hot';

  @override
  String get optCold => 'Cold';

  @override
  String get optAnyTemp => 'Doesn\'t matter';

  @override
  String get qTypeTitle => 'What type of drink would you like?';

  @override
  String get optTea => 'Tea';

  @override
  String get optCoffee => 'Coffee';

  @override
  String get optFruitJuice => 'Fruit Juice';

  @override
  String get optAnyType => 'Doesn\'t matter';

  @override
  String get btnNext => 'Next';

  @override
  String get btnBack => 'Back';

  @override
  String get btnGetSuggestion => 'Get Suggestion';

  @override
  String get btnRetake => 'Retake Quiz';

  @override
  String get yourPreferencesTitle => 'Your Preferences';

  @override
  String prefTasteLabel(Object val) {
    return 'Flavor: $val';
  }

  @override
  String prefTempLabel(Object val) {
    return 'Temperature: $val';
  }

  @override
  String prefTypeLabel(Object val) {
    return 'Drink type: $val';
  }

  @override
  String get matchedDrinksTitle => 'Matching Drinks';

  @override
  String minutes(int count) {
    return '$count minutes';
  }

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get ingredientsTitle => 'Ingredients';

  @override
  String get preparedProgress => 'Prepared';

  @override
  String get stepsTitle => 'Steps';

  @override
  String get emptySavedDrinksTitle => 'No saved drinks yet';

  @override
  String get emptySavedDrinksMessage =>
      'Tap the bookmark icon to save your favorite recipes.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get userRole => 'USER';

  @override
  String get adminRole => 'ADMIN';

  @override
  String get submittedComments => 'Submitted Comments & Feedback';

  @override
  String get submittedCommentsDescription =>
      'Share your thoughts about drink recipes';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get phone => 'Phone';

  @override
  String get joinedDate => 'Joined Date';

  @override
  String get logout => 'Log Out';

  @override
  String get aboutDescription =>
      'A drink recipe app that helps you discover and save your favorite recipes.';

  @override
  String get subjectLabel => 'Subject:';

  @override
  String get subjectValue => 'Mobile Device Programming';

  @override
  String get lecturerLabel => 'Lecturer:';

  @override
  String get lecturerValue => 'MSc/PhD candidate Nguyen Xuan Que';

  @override
  String get groupLabel => 'Group:';

  @override
  String get groupValue => 'Group 8';

  @override
  String get membersLabel => 'Members:';

  @override
  String get membersValue =>
      '- Ho Sy Long – 24100319\n- Nguyen Le Trung Nguyen – 24100298\n- Phan Thi Ngan Quynh – 24100457';

  @override
  String get commentSent =>
      'Your comment was sent and is waiting for Admin approval!';

  @override
  String get commentsTitle => 'Ratings & Comments';

  @override
  String get ratingLabel => 'Rating:';

  @override
  String get commentHint => 'Share your thoughts about this recipe...';

  @override
  String get noComments => 'No comments to display.';

  @override
  String get systemAdministrator => 'System Administrator';

  @override
  String get systemAdminRole => 'System Administrator';

  @override
  String get adminDashboard => 'Admin Dashboard';

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get fullName => 'Full Name';

  @override
  String get emailAddressFixed => 'Email Address (Fixed)';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get avatarUrl => 'Avatar URL';

  @override
  String get changePassword => 'Change Password';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get welcomeAdmin => 'Welcome Admin';

  @override
  String welcomeLoginSuccess(String name) {
    return 'Welcome $name! Login successful.';
  }

  @override
  String get fullSystemAdministrationRights =>
      'Full System Administration Rights';

  @override
  String get systemStatistics => 'System Statistics';

  @override
  String get managementShortcuts => 'Management Shortcuts';

  @override
  String get drinksAndRecipes => 'Drinks & Recipes';

  @override
  String get viewEditRecipes => 'View & edit recipes';

  @override
  String get drinkCategories => 'Drink Categories';

  @override
  String get menuClassification => 'Menu classification';

  @override
  String get storageIngredients => 'Storage Ingredients';

  @override
  String get quantitiesAndUnits => 'Quantities & units';

  @override
  String get pendingComments => 'Pending Comments';

  @override
  String get allApproved => 'All approved';

  @override
  String get manageDrinksRecipes => 'Manage Drinks & Recipes';

  @override
  String get addEditRecipesIngredients =>
      'Add, edit recipes & ingredient quantities';

  @override
  String get manageDrinkCategories => 'Manage Drink Categories';

  @override
  String get classifyDrinkCategories =>
      'Classify coffee, milk tea, smoothies, mocktails';

  @override
  String get manageIngredients => 'Manage Ingredients';

  @override
  String get standardInventoryUnits => 'Standard inventory & units';

  @override
  String get moderateComments => 'Moderate Comments';

  @override
  String approveDeleteComments(int count) {
    return 'Approve or delete comments ($count pending)';
  }

  @override
  String registeredUserAccounts(int count) {
    return 'The system currently has $count registered user accounts.';
  }

  @override
  String get manageDrinksTitle => 'Manage Drinks & Recipes';

  @override
  String get manageCategoriesTitle => 'Manage Drink Categories';

  @override
  String get manageIngredientsTitle => 'Manage Ingredients';

  @override
  String get moderateCommentsTitle => 'Moderate Comments';

  @override
  String get pendingTab => 'Pending';

  @override
  String get allCommentsTab => 'All comments';

  @override
  String get noPendingComments => 'No pending comments';

  @override
  String get addDrink => 'Add Drink';

  @override
  String get addCategory => 'Add Category';

  @override
  String get addIngredient => 'Add Ingredient';

  @override
  String get searchByNameDescription => 'Search by name or description...';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get update => 'Update';

  @override
  String get addNew => 'Add New';

  @override
  String get confirmDelete => 'Confirm deletion';

  @override
  String get approve => 'Approve';

  @override
  String allDrinksCount(int count) {
    return 'All ($count)';
  }

  @override
  String get noCategories => 'No categories yet.';

  @override
  String get noIngredients => 'No ingredients yet.';

  @override
  String get noPendingItems => 'No pending items.';

  @override
  String deleteDrinkConfirmation(Object name) {
    return 'Are you sure you want to delete \"$name\" from the system?';
  }

  @override
  String deleteCategoryConfirmation(Object name) {
    return 'Are you sure you want to delete category \"$name\"?';
  }

  @override
  String deleteIngredientConfirmation(Object name) {
    return 'Are you sure you want to delete ingredient \"$name\"?';
  }

  @override
  String get drinkManagementSubtitle =>
      'Add, edit recipes & ingredient quantities';

  @override
  String get categoryManagementSubtitle =>
      'Classify coffee, milk tea, smoothies, mocktails';

  @override
  String get ingredientManagementSubtitle => 'Standard inventory & units';

  @override
  String get editIngredient => 'Edit Ingredient';

  @override
  String get ingredientName => 'Ingredient Name';

  @override
  String get unit => 'Unit';

  @override
  String get noteDescription => 'Note / Description';

  @override
  String get updateDrink => 'Update Drink';

  @override
  String get recipeSteps => 'Recipe Steps';

  @override
  String get addStep => 'Add Step';

  @override
  String get chooseIngredient => 'Choose ingredient';

  @override
  String amount(Object unit) {
    return 'Amount ($unit)';
  }

  @override
  String get addIngredientToRecipe => 'Add ingredient to recipe';

  @override
  String get noIngredientInventory =>
      'Please create at least one ingredient in the inventory first!';

  @override
  String get atLeastOneIngredient => 'Please add at least one ingredient!';

  @override
  String unitLabel(Object unit) {
    return 'Unit: $unit';
  }

  @override
  String stepPlaceholder(int number) {
    return 'Enter instructions for step $number...';
  }

  @override
  String get drinkName => 'Drink Name';

  @override
  String get drinkCategory => 'Drink Category';

  @override
  String get drinkDescription => 'Flavor & Description';

  @override
  String get drinkDescriptionHint =>
      'Describe the drink\'s flavor and characteristics...';

  @override
  String get imageUrl => 'Image URL';

  @override
  String get preparationTime => 'Time (minutes)';

  @override
  String get minuteUnit => 'minutes';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get ingredientsForDrink => 'Ingredients to use';

  @override
  String get addIngredientToDrink => 'Add ingredient';

  @override
  String get noIngredientsInstruction =>
      'No ingredients yet. Tap \"Add ingredient\" above.';

  @override
  String get saveDrinkRecipe => 'Save Drink & Recipe';

  @override
  String get editCategoryTitle => 'Edit Category';

  @override
  String get categoryNameLabel => 'Category Name';

  @override
  String get shortDescriptionLabel => 'Short Description';

  @override
  String categorySubtitleText(int count) {
    return '$count recipes • Tap to view details →';
  }

  @override
  String ingredientStepCount(int ingredients, int steps) {
    return '$ingredients ingredients • $steps steps';
  }

  @override
  String get noDrinkRecipes => 'No drink recipes found.';

  @override
  String get viewAllCategories => 'View all categories';

  @override
  String get editRecipe => 'Edit recipe';

  @override
  String get registerTitle => 'Register Account';

  @override
  String get registerSubtitle => 'Discover countless top drink recipes';

  @override
  String get registerSuccess => 'Account registration successful!';

  @override
  String get registerFailed => 'Registration failed, please try again.';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your registered email to receive a password reset link.';

  @override
  String get resetPasswordSent => 'Reset link sent to your email!';

  @override
  String get resetPasswordFailed => 'Request failed, please try again.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get loginNow => 'Login now';

  @override
  String get registerNow => 'Register now';

  @override
  String get forgotPasswordQuestion => 'Forgot password?';

  @override
  String get sendResetRequest => 'Send Request';

  @override
  String get notUpdated => 'Not updated';

  @override
  String get uncategorized => 'Uncategorized';

  @override
  String get guest => 'Guest';

  @override
  String get pendingCommentsBadge => 'Pending comments require attention';

  @override
  String drinkLabel(String name) {
    return 'Drink: $name';
  }

  @override
  String get defaultStep1 => 'Prepare ingredients and utensils.';

  @override
  String get defaultStep2 => 'Mix according to measurements.';

  @override
  String get valRequired => 'This field is required';

  @override
  String get valInvalidEmail => 'Invalid email address';

  @override
  String get valPasswordLength => 'Password must be at least 6 characters';

  @override
  String get valPasswordMismatch => 'Passwords do not match';

  @override
  String get valPhoneInvalid => 'Invalid phone number';

  @override
  String get loginSubtitle => 'Sign in to manage recipes and brewing';

  @override
  String get quickTestAccounts => '⚡ Quick-fill test account:';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Enter password';

  @override
  String get registerHeading => 'Create New Account';

  @override
  String get nameHint => 'Example: Nguyen Van A';

  @override
  String get emailAddressLabel => 'Email Address';

  @override
  String get phoneOptionalLabel => 'Phone number (optional)';

  @override
  String get passwordLengthHint => 'At least 6 characters';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get newPasswordLabel => 'New password';

  @override
  String get confirmNewPasswordLabel => 'Confirm new password';

  @override
  String get confirmNewPasswordHint => 'Re-enter the new password';

  @override
  String get loginTitle => 'Login';

  @override
  String get loginFailed => 'Login failed.';

  @override
  String get profileUpdateFailed => 'Update failed.';

  @override
  String get nameInputHint => 'Enter your full name';

  @override
  String get emailReadonlyTooltip =>
      'Email identifies your account and cannot be changed';

  @override
  String get currentPasswordLabel => 'Current password';

  @override
  String get currentPasswordHint => 'Enter your current password';

  @override
  String get newPasswordHint => 'At least 6 characters';

  @override
  String get ingredientNameHint => 'Example: Ong Tho condensed milk';

  @override
  String get unitHint => 'ml, g, piece(s), leaf, spoon...';

  @override
  String get descriptionHint => 'Characteristics and storage instructions...';

  @override
  String get categoryNameHint => 'Example: Fruit tea';

  @override
  String get categoryDescriptionHint => 'Describe the category...';

  @override
  String get imageUrlLabel => 'Image URL';

  @override
  String get imageUrlHint => 'https://images.unsplash.com/...';

  @override
  String get drinkNameHint => 'Example: Hue Salt Coffee';

  @override
  String get phoneHint => '0901234567';

  @override
  String get editLabel => 'Edit';

  @override
  String get emailAlreadyRegistered => 'This email is already registered.';

  @override
  String get invalidCredentials => 'Incorrect email or password.';

  @override
  String get accountNotFound => 'Account not found.';

  @override
  String get currentPasswordIncorrect => 'The current password is incorrect.';
}
