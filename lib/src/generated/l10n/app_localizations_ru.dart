// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => 'Загрузка...';

  @override
  String errorMessage(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get cancelButton => 'Отмена';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get selectButton => 'Выбрать';

  @override
  String get refreshButton => 'Обновить';

  @override
  String get deleteButton => 'Удалить';

  @override
  String get editButton => 'Редактировать';

  @override
  String get noData => 'Нет данных';

  @override
  String get retryButton => 'Попробовать снова';

  @override
  String get orSeparator => 'или';

  @override
  String get enabledLabel => 'Включено';

  @override
  String get disabledLabel => 'Выключено';

  @override
  String get okButton => 'Ok';

  @override
  String get navHome => 'Главная';

  @override
  String get navOverview => 'Обзор';

  @override
  String get navSuggestions => 'Рекомендации';

  @override
  String get navSettings => 'Настройки';

  @override
  String get loginTitle => 'Вход в учётную запись';

  @override
  String get usernameHint => 'Имя пользователя / Email';

  @override
  String get passwordHint => 'Пароль';

  @override
  String get loginButton => 'Войти';

  @override
  String get continueAsGuest => 'Продолжить как гость';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get continueWithFacebook => 'Продолжить с Facebook';

  @override
  String get continueWithGoogle => 'Продолжить с Google';

  @override
  String get noAccount => 'Нет учётной записи?';

  @override
  String get signUpButton => 'Регистрация';

  @override
  String get signUpOrLogin => 'Регистрация или вход';

  @override
  String get guestMode => 'Вы сейчас в гостевом режиме';

  @override
  String get settings => 'Настройки';

  @override
  String get changeAppLanguage => 'Изменить язык приложения';

  @override
  String get languageTitle => 'Язык';

  @override
  String get weekStartsOnTitle => 'Неделя начинается с';

  @override
  String get mondayLabel => 'Понедельника';

  @override
  String get sundayLabel => 'Воскресенья';

  @override
  String get notifications => 'Уведомления';

  @override
  String get termsOfUse => 'Условия использования';

  @override
  String get termsOfUseTitle => 'Условия использования';

  @override
  String errorLoadingTerms(Object error) {
    return 'Ошибка загрузки условий: $error';
  }

  @override
  String get languageSelectorTitle => 'Выберите язык';

  @override
  String get englishLanguage => 'Английский';

  @override
  String get vietnameseLanguage => 'Вьетнамский';

  @override
  String get spanishLanguage => 'Испанский';

  @override
  String get frenchLanguage => 'Французский';

  @override
  String get chineseLanguage => 'Китайский';

  @override
  String get germanLanguage => 'Немецкий';

  @override
  String get japaneseLanguage => 'Японский';

  @override
  String get russianLanguage => 'Русский';

  @override
  String get hindiLanguage => 'Хинди';

  @override
  String get koreanLanguage => 'Корейский';

  @override
  String get createHabitTitle => 'Создать привычку';

  @override
  String get editHabitTitle => 'Редактировать привычку';

  @override
  String get habitNameLabel => 'Название привычки';

  @override
  String get noHabitsMessage =>
      'Пока нет привычек. Нажмите \'+\', чтобы добавить свою привычку!';

  @override
  String get saveHabitButton => 'Сохранить привычку';

  @override
  String repeatsEvery(String frequency) {
    return 'Повторяется каждые $frequency';
  }

  @override
  String get hasReminder => 'Напоминание включено';

  @override
  String get noReminder => 'Напоминание выключено';

  @override
  String get selectCategoryLabel => 'Выберите категорию';

  @override
  String get selectACategoryDefault => 'Выберите категорию';

  @override
  String get selectDateLabel => 'Выберите дату';

  @override
  String get timeLabel => 'Время';

  @override
  String get repeatLabel => 'Повторять';

  @override
  String get trackingTypeLabel => 'Тип отслеживания';

  @override
  String get trackingTypeComplete => 'Завершено';

  @override
  String get trackingTypeProgress => 'Прогресс';

  @override
  String get categoryLabel => 'Категория';

  @override
  String get dateLabel => 'Дата';

  @override
  String get timeViewLabel => 'Время';

  @override
  String get repeatViewLabel => 'Повторять';

  @override
  String get reminderLabel => 'Напоминание';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return 'Цель: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => 'ед.';

  @override
  String get enableNotificationsLabel => 'Включить уведомления';

  @override
  String get setProgressGoalDialogTitle => 'Установить цель прогресса';

  @override
  String get quantityLabel => 'Количество';

  @override
  String get unitLabel => 'Единица измерения';

  @override
  String get updateProgressTitle => 'Обновить прогресс';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => 'Выберите повторение';

  @override
  String get noRepeatLabel => 'Без повторения';

  @override
  String get repeatDaily => 'Ежедневно';

  @override
  String get repeatWeekly => 'Еженедельно';

  @override
  String get repeatMonthly => 'Ежемесячно';

  @override
  String get repeatYearly => 'Ежегодно';

  @override
  String get selectCategoryTitle => 'Выберите категорию';

  @override
  String get categoryTitle => 'Категория';

  @override
  String get othersLabel => 'Другие';

  @override
  String get categoryHealth => 'Здоровье';

  @override
  String get categoryWork => 'Работа';

  @override
  String get categoryPersonalGrowth => 'Личный рост';

  @override
  String get categoryHobby => 'Хобби';

  @override
  String get categoryFitness => 'Фитнес';

  @override
  String get categoryEducation => 'Образование';

  @override
  String get categoryFinance => 'Финансы';

  @override
  String get categorySocial => 'Социальное';

  @override
  String get categorySpiritual => 'Духовное';

  @override
  String get totalHabits => 'Всего';

  @override
  String get completionRate => 'Процент выполнения';

  @override
  String get completeHabits => 'Завершенные';

  @override
  String get progressHabits => 'В процессе';

  @override
  String get selectMonth => 'Выберите месяц';

  @override
  String get selectMonthTitle => 'Выберите месяц';

  @override
  String errorLoadingChartData(Object error) {
    return 'Ошибка загрузки данных диаграммы: $error';
  }

  @override
  String get noHabitDataMonth => 'Нет данных о привычках за этот месяц';

  @override
  String get suggestionTitle => 'Рекомендации по оптимизации';

  @override
  String get noSuggestionsAvailable =>
      'Сейчас нет доступных предложений. Загляните позже за новыми идеями по оптимизации!';

  @override
  String get aiRecommendationsFailedMessage =>
      'Не удалось загрузить рекомендации ИИ';

  @override
  String get tryAgainLaterMessage =>
      'Возникли проблемы с подключением к системе рекомендаций. Пожалуйста, попробуйте позже или изучите доступные планы.';

  @override
  String get suggestionLoadingTitle => 'Подождите, ищем подходящие предложения';

  @override
  String get suggestionLoadingDescription =>
      'Мы подготовили для вас персонализированные рекомендации по полезным привычкам в категориях Здоровье, Продуктивность, Осознанность, Обучение и других.';

  @override
  String get filterAll => 'Все';

  @override
  String get filterMostFrequent => 'Наиболее частые';

  @override
  String get filterTopPerformed => 'Лучшие результаты';

  @override
  String noHabitsInCategory(String month) {
    return 'В этой категории нет привычек за $month';
  }

  @override
  String get noRankedItemsAvailable => 'Нет доступных элементов';

  @override
  String get filterByCategoryLabel => 'Фильтровать по категории';

  @override
  String get filterByCategoryTitle => 'Фильтровать по категории';

  @override
  String get allCategoriesLabel => 'Все категории';

  @override
  String get noHabitsInCategoryMessage => 'В этой категории нет привычек';

  @override
  String get clearFilterTooltip => 'Сбросить фильтр';

  @override
  String get showAllHabitsButton => 'Показать все привычки';

  @override
  String get addProgressTitle => 'Добавить прогресс';

  @override
  String get enterProgressLabel => 'Введите значение';

  @override
  String get enterNumberEmptyError => 'Пожалуйста, введите значение';

  @override
  String get enterNumberInvalidError => 'Введите корректное число';

  @override
  String get habitDeletedSuccess => 'Привычка успешно удалена!';

  @override
  String get habitDeleteFailed => 'Не удалось удалить привычку!';

  @override
  String get cannotRecordFutureHabit =>
      'Нельзя записывать привычку для будущей даты.';

  @override
  String get failedToUpdateHabit =>
      'Не удалось обновить привычку. Пожалуйста, попробуйте ещё раз.';

  @override
  String get failedToUpdateProgress =>
      'Не удалось обновить прогресс. Пожалуйста, попробуйте ещё раз.';

  @override
  String get scopeDialogDefaultTitle => 'Применить изменения к...';

  @override
  String get deleteHabitDialogTitle => 'Удалить привычку?';

  @override
  String get deleteHabitDialogMessage =>
      'Вы уверены, что хотите удалить эту привычку?';

  @override
  String get scopeOptionOnlyThis => 'Только эта привычка';

  @override
  String get scopeOptionThisAndFuture => 'Эта и будущие привычки';

  @override
  String get scopeOptionAllInSeries => 'Все привычки в этой серии';

  @override
  String get themeSelectionTitle => 'Внешний вид';

  @override
  String get themeModeLight => 'Светлая';

  @override
  String get themeModeDark => 'Темная';

  @override
  String get themeModeSystem => 'Использовать настройки устройства';

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get applySelected => 'Применить выбранные';

  @override
  String get habitsApplied => 'Выбранные предложения применены';

  @override
  String get habitAdded => 'Привычка успешно добавлена';

  @override
  String get habitAddError => 'Не удалось добавить привычку';

  @override
  String get applySuggestion => 'Применить предложение';

  @override
  String get appliedHabitsSuccessTitle => 'Успешно!';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Применено $count привычек',
      many: 'Применено $count привычек',
      few: 'Применено $count привычки',
      two: 'Применено 2 привычки',
      one: 'Применена 1 привычка',
      zero: 'Применено 0 привычек',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription =>
      'Теперь эти привычки являются частью вашей рутины.';

  @override
  String get backToSuggestionsButton => 'Назад к предложениям';

  @override
  String get goToHomeButton => 'На главную';

  @override
  String get viewDetailsButton => 'Посмотреть подробности';

  @override
  String get appliedHabitsSummaryTitle => 'Применённые привычки';

  @override
  String get aiPicksTab => 'Подборки от ИИ';

  @override
  String get habitPlansTab => 'Планы привычек';

  @override
  String get exploreHabitPlans => 'Просмотреть планы привычек';

  @override
  String habitPlansError(Object error) {
    return 'Ошибка загрузки планов привычек: $error';
  }

  @override
  String get aboutThisPlan => 'Об этом плане';

  @override
  String get includedHabits => 'Включенные привычки';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Выбрано $count привычек',
      many: 'Выбрано $count привычек',
      few: 'Выбрано $count привычки',
      one: 'Выбрана 1 привычка',
      zero: 'Не выбрано ни одной привычки',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'Нет интернет-соединения';

  @override
  String get noInternetConnectionDescription =>
      'Пожалуйста, проверьте ваше интернет-соединение и попробуйте ещё раз. Некоторые функции могут быть недоступны в автономном режиме.';

  @override
  String get retry => 'Повторить';

  @override
  String get viewOfflineContent => 'Просмотреть доступный контент';

  @override
  String get personalizedSuggestionsWelcome =>
      'Персонализированные советы по привычкам от ИИ';

  @override
  String get goalsHint => 'Расскажите мне о своих целях...';

  @override
  String get personalityLabel => 'Личность';

  @override
  String get availableTimeLabel => 'Доступное время';

  @override
  String get guidanceLevelLabel => 'Уровень руководства';

  @override
  String get selectPersonalityTitle => 'Выберите личность';

  @override
  String get selectAvailableTimeTitle => 'Выберите доступное время';

  @override
  String get selectGuidanceLevelTitle => 'Выберите уровень руководства';

  @override
  String get selectDataSourceTitle => 'Выберите источник данных';

  @override
  String get personalityIntroverted => 'Интроверт';

  @override
  String get personalityExtroverted => 'Экстраверт';

  @override
  String get personalityDisciplined => 'Дисциплинированный';

  @override
  String get personalityCreative => 'Креативный';

  @override
  String get personalityAnalytical => 'Аналитический';

  @override
  String get timeMorning => 'Утро';

  @override
  String get timeNoon => 'Полдень';

  @override
  String get timeAfternoon => 'День';

  @override
  String get timeEvening => 'Вечер';

  @override
  String get timeFlexible => 'Гибкое';

  @override
  String get guidanceSimple => 'Простой';

  @override
  String get guidanceIntermediate => 'Средний';

  @override
  String get guidanceAdvanced => 'Продвинутый';

  @override
  String get dataSourcePersonalizationOnly => 'Только персонализация';

  @override
  String get dataSourceHabitsOnly => 'Только привычки';

  @override
  String get dataSourceBoth => 'И то, и другое';
}
