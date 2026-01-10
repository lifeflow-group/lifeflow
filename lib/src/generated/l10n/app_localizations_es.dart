// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => 'Cargando...';

  @override
  String errorMessage(Object error) {
    return 'Error: $error';
  }

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get saveButton => 'Guardar';

  @override
  String get selectButton => 'Seleccionar';

  @override
  String get refreshButton => 'Actualizar';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get editButton => 'Editar';

  @override
  String get noData => 'No hay datos disponibles';

  @override
  String get retryButton => 'Intentar de nuevo';

  @override
  String get orSeparator => 'o';

  @override
  String get enabledLabel => 'Activado';

  @override
  String get disabledLabel => 'Desactivado';

  @override
  String get okButton => 'Aceptar';

  @override
  String get navHome => 'Inicio';

  @override
  String get navOverview => 'Resumen';

  @override
  String get navSuggestions => 'Sugerencias';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get loginTitle => 'Iniciar sesión con la cuenta';

  @override
  String get usernameHint => 'Nombre de usuario / Correo electrónico';

  @override
  String get passwordHint => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get continueAsGuest => 'Continuar como invitado';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get continueWithFacebook => 'Continuar con Facebook';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get noAccount => '¿No tienes una cuenta?';

  @override
  String get signUpButton => 'Registrarse';

  @override
  String get signUpOrLogin => 'Regístrate o inicia sesión';

  @override
  String get guestMode => 'Actualmente estás en modo invitado';

  @override
  String get settings => 'Ajustes';

  @override
  String get changeAppLanguage => 'Cambiar idioma de la aplicación';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get weekStartsOnTitle => 'Semana comienza en';

  @override
  String get mondayLabel => 'Lunes';

  @override
  String get sundayLabel => 'Domingo';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get termsOfUse => 'Términos de uso';

  @override
  String get termsOfUseTitle => 'Términos de Uso';

  @override
  String errorLoadingTerms(Object error) {
    return 'Error al cargar los términos: $error';
  }

  @override
  String get languageSelectorTitle => 'Seleccionar idioma';

  @override
  String get englishLanguage => 'Inglés';

  @override
  String get vietnameseLanguage => 'Vietnamita';

  @override
  String get spanishLanguage => 'Español';

  @override
  String get frenchLanguage => 'Francés';

  @override
  String get chineseLanguage => 'Chino';

  @override
  String get germanLanguage => 'Alemán';

  @override
  String get japaneseLanguage => 'Japonés';

  @override
  String get russianLanguage => 'Ruso';

  @override
  String get hindiLanguage => 'Hindi';

  @override
  String get koreanLanguage => 'Coreano';

  @override
  String get createHabitTitle => 'Crear hábito';

  @override
  String get editHabitTitle => 'Editar hábito';

  @override
  String get habitNameLabel => 'Nombre del hábito';

  @override
  String get noHabitsMessage =>
      '¡Aún no hay hábitos. Toca \'+\' para agregar tu hábito!';

  @override
  String get saveHabitButton => 'Guardar hábito';

  @override
  String repeatsEvery(String frequency) {
    return 'Se repite cada $frequency';
  }

  @override
  String get hasReminder => 'Tiene recordatorio';

  @override
  String get noReminder => 'Sin recordatorio';

  @override
  String get selectCategoryLabel => 'Seleccionar categoría';

  @override
  String get selectACategoryDefault => 'Seleccionar una categoría';

  @override
  String get selectDateLabel => 'Seleccionar fecha';

  @override
  String get timeLabel => 'Hora';

  @override
  String get repeatLabel => 'Repetir';

  @override
  String get trackingTypeLabel => 'Tipo de seguimiento';

  @override
  String get trackingTypeComplete => 'Completo';

  @override
  String get trackingTypeProgress => 'Progreso';

  @override
  String get categoryLabel => 'Categoría';

  @override
  String get dateLabel => 'Fecha';

  @override
  String get timeViewLabel => 'Hora';

  @override
  String get repeatViewLabel => 'Repetir';

  @override
  String get reminderLabel => 'Recordatorio';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return 'Objetivo: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => 'unidad';

  @override
  String get enableNotificationsLabel => 'Activar notificaciones';

  @override
  String get setProgressGoalDialogTitle => 'Establecer objetivo de progreso';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get unitLabel => 'Unidad';

  @override
  String get updateProgressTitle => 'Actualizar progreso';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => 'Seleccionar repetición';

  @override
  String get noRepeatLabel => 'Sin repetición';

  @override
  String get repeatDaily => 'Diario';

  @override
  String get repeatWeekly => 'Semanal';

  @override
  String get repeatMonthly => 'Mensual';

  @override
  String get repeatYearly => 'Anual';

  @override
  String get selectCategoryTitle => 'Seleccionar una categoría';

  @override
  String get categoryTitle => 'Categoría';

  @override
  String get othersLabel => 'Otros';

  @override
  String get categoryHealth => 'Salud';

  @override
  String get categoryWork => 'Trabajo';

  @override
  String get categoryPersonalGrowth => 'Crecimiento personal';

  @override
  String get categoryHobby => 'Afición';

  @override
  String get categoryFitness => 'Forma física';

  @override
  String get categoryEducation => 'Educación';

  @override
  String get categoryFinance => 'Finanzas';

  @override
  String get categorySocial => 'Social';

  @override
  String get categorySpiritual => 'Espiritual';

  @override
  String get totalHabits => 'Total';

  @override
  String get completionRate => 'Tasa';

  @override
  String get completeHabits => 'Completos';

  @override
  String get progressHabits => 'En progreso';

  @override
  String get selectMonth => 'Seleccionar mes';

  @override
  String get selectMonthTitle => 'Seleccionar mes';

  @override
  String errorLoadingChartData(Object error) {
    return 'Error al cargar los datos del gráfico: $error';
  }

  @override
  String get noHabitDataMonth =>
      'No hay datos de hábitos disponibles para este mes';

  @override
  String get suggestionTitle => 'Sugerencias de optimización';

  @override
  String get noSuggestionsAvailable =>
      'No hay sugerencias disponibles por el momento. ¡Vuelve a consultar más tarde para obtener ideas de optimización!';

  @override
  String get aiRecommendationsFailedMessage =>
      'No se pudieron cargar las recomendaciones de IA';

  @override
  String get tryAgainLaterMessage =>
      'Estamos experimentando problemas para conectarnos a nuestro sistema de sugerencias. Inténtalo de nuevo más tarde o explora los planes disponibles.';

  @override
  String get suggestionLoadingTitle => 'Veamos sugerencias';

  @override
  String get suggestionLoadingDescription =>
      'Tus sugerencias de hábitos optimizadas están diseñadas para ti y abarcan categorías como Salud, Productividad, Atención plena, Aprendizaje y más.';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterMostFrequent => 'Más frecuentes';

  @override
  String get filterTopPerformed => 'Mejores resultados';

  @override
  String noHabitsInCategory(String month) {
    return 'No hay hábitos en esta categoría para $month';
  }

  @override
  String get noRankedItemsAvailable => 'No hay elementos disponibles';

  @override
  String get filterByCategoryLabel => 'Filtrar por categoría';

  @override
  String get filterByCategoryTitle => 'Filtrar por categoría';

  @override
  String get allCategoriesLabel => 'Todas las categorías';

  @override
  String get noHabitsInCategoryMessage =>
      'No se encontraron hábitos en esta categoría';

  @override
  String get clearFilterTooltip => 'Borrar filtro';

  @override
  String get showAllHabitsButton => 'Mostrar todos los hábitos';

  @override
  String get addProgressTitle => 'Añadir progreso';

  @override
  String get enterProgressLabel => 'Introduce un valor';

  @override
  String get enterNumberEmptyError => 'Por favor, introduce un valor';

  @override
  String get enterNumberInvalidError => 'Introduce un número válido';

  @override
  String get habitDeletedSuccess => '¡Hábito eliminado correctamente!';

  @override
  String get habitDeleteFailed => '¡Error al eliminar el hábito!';

  @override
  String get cannotRecordFutureHabit =>
      'No se puede registrar el hábito para una fecha futura.';

  @override
  String get failedToUpdateHabit =>
      'Error al actualizar el hábito. Por favor, inténtalo de nuevo.';

  @override
  String get failedToUpdateProgress =>
      'Error al actualizar el progreso. Por favor, inténtalo de nuevo.';

  @override
  String get scopeDialogDefaultTitle => 'Aplicar cambios a...';

  @override
  String get deleteHabitDialogTitle => '¿Eliminar hábito?';

  @override
  String get deleteHabitDialogMessage =>
      '¿Estás seguro de que quieres eliminar este hábito?';

  @override
  String get scopeOptionOnlyThis => 'Solo este hábito';

  @override
  String get scopeOptionThisAndFuture => 'Este y futuros hábitos';

  @override
  String get scopeOptionAllInSeries => 'Todos los hábitos de esta serie';

  @override
  String get themeSelectionTitle => 'Apariencia';

  @override
  String get themeModeLight => 'Claro';

  @override
  String get themeModeDark => 'Oscuro';

  @override
  String get themeModeSystem => 'Usar configuración del dispositivo';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get applySelected => 'Aplicar seleccionados';

  @override
  String get habitsApplied => 'Sugerencias seleccionadas aplicadas';

  @override
  String get habitAdded => 'Hábito añadido correctamente';

  @override
  String get habitAddError => 'Error al añadir el hábito';

  @override
  String get applySuggestion => 'Aplicar sugerencia';

  @override
  String get appliedHabitsSuccessTitle => '¡Éxito!';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# hábitos aplicados correctamente',
      one: '1 hábito aplicado correctamente',
      zero: 'No se aplicaron hábitos',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription =>
      'Estos hábitos ahora son parte de tu rutina.';

  @override
  String get backToSuggestionsButton => 'Volver a Sugerencias';

  @override
  String get goToHomeButton => 'Ir a Inicio';

  @override
  String get viewDetailsButton => 'Ver detalles';

  @override
  String get appliedHabitsSummaryTitle => 'Hábitos Aplicados';

  @override
  String get aiPicksTab => 'Recomendaciones de IA';

  @override
  String get habitPlansTab => 'Planes de hábitos';

  @override
  String get exploreHabitPlans => 'Explorar planes de hábitos';

  @override
  String habitPlansError(Object error) {
    return 'Error al cargar los planes de hábitos: $error';
  }

  @override
  String get aboutThisPlan => 'Acerca de este plan';

  @override
  String get includedHabits => 'Hábitos incluidos';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# hábitos seleccionados',
      one: '1 hábito seleccionado',
      zero: 'No se ha seleccionado ningún hábito',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'Sin conexión a internet';

  @override
  String get noInternetConnectionDescription =>
      'Por favor, revisa tu conexión a internet e inténtalo de nuevo. Algunas funciones pueden no estar disponibles sin conexión.';

  @override
  String get retry => 'Reintentar';

  @override
  String get viewOfflineContent => 'Ver contenido disponible';

  @override
  String get personalizedSuggestionsWelcome =>
      'Sugerencias de hábitos personalizadas con IA';

  @override
  String get goalsHint => 'Cuéntame sobre tus objetivos...';

  @override
  String get personalityLabel => 'Personalidad';

  @override
  String get availableTimeLabel => 'Tiempo disponible';

  @override
  String get guidanceLevelLabel => 'Nivel de orientación';

  @override
  String get selectPersonalityTitle => 'Seleccionar personalidad';

  @override
  String get selectAvailableTimeTitle => 'Seleccionar tiempo disponible';

  @override
  String get selectGuidanceLevelTitle => 'Seleccionar nivel de orientación';

  @override
  String get selectDataSourceTitle => 'Seleccionar fuente de datos';

  @override
  String get personalityIntroverted => 'Introvertido';

  @override
  String get personalityExtroverted => 'Extrovertido';

  @override
  String get personalityDisciplined => 'Disciplinado';

  @override
  String get personalityCreative => 'Creativo';

  @override
  String get personalityAnalytical => 'Analítico';

  @override
  String get timeMorning => 'Mañana';

  @override
  String get timeNoon => 'Mediodía';

  @override
  String get timeAfternoon => 'Tarde';

  @override
  String get timeEvening => 'Noche';

  @override
  String get timeFlexible => 'Flexible';

  @override
  String get guidanceSimple => 'Simple';

  @override
  String get guidanceIntermediate => 'Intermedio';

  @override
  String get guidanceAdvanced => 'Avanzado';

  @override
  String get dataSourcePersonalizationOnly => 'Solo personalización';

  @override
  String get dataSourceHabitsOnly => 'Solo hábitos';

  @override
  String get dataSourceBoth => 'Ambos';
}
