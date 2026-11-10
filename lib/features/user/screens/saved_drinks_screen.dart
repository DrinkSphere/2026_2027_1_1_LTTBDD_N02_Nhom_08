import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/language_toggle_button.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/drink_provider.dart';
import 'drink_detail_screen.dart';
import 'home_screen.dart';

class SavedDrinksScreen extends StatelessWidget {
  const SavedDrinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final drinkProvider = context.watch<DrinkProvider>();
    final savedDrinks = drinkProvider.savedDrinks;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.savedDrinksTitle),
        actions: const [LanguageToggleButton()],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: savedDrinks.isEmpty
              ? const _EmptySavedDrinks()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemCount: savedDrinks.length,
                  itemBuilder: (context, index) {
                    final drink = savedDrinks[index];
                    return DrinkCard(
                      drink: drink,
                      categoryName: drinkProvider.getCategoryName(
                        context,
                        drink.categoryId,
                      ),
                      isSaved: true,
                      onSaveToggle: () =>
                          drinkProvider.toggleDrinkSaved(drink.id),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DrinkDetailScreen(drink: drink),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class _EmptySavedDrinks extends StatelessWidget {
  const _EmptySavedDrinks();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: AppColors.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.emptySavedDrinksTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.emptySavedDrinksMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
