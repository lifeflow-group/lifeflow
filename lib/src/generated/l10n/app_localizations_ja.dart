// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => '読み込み中...';

  @override
  String errorMessage(Object error) {
    return 'エラー: $error';
  }

  @override
  String get cancelButton => 'キャンセル';

  @override
  String get saveButton => '保存';

  @override
  String get selectButton => '選択';

  @override
  String get refreshButton => '更新';

  @override
  String get deleteButton => '削除';

  @override
  String get editButton => '編集';

  @override
  String get noData => 'データがありません';

  @override
  String get retryButton => '再試行';

  @override
  String get orSeparator => 'または';

  @override
  String get enabledLabel => '有効';

  @override
  String get disabledLabel => '無効';

  @override
  String get okButton => 'OK';

  @override
  String get navHome => 'ホーム';

  @override
  String get navOverview => '概要';

  @override
  String get navSuggestions => '提案';

  @override
  String get navSettings => '設定';

  @override
  String get loginTitle => 'アカウントでログイン';

  @override
  String get usernameHint => 'ユーザー名／メールアドレス';

  @override
  String get passwordHint => 'パスワード';

  @override
  String get loginButton => 'ログイン';

  @override
  String get continueAsGuest => 'ゲストとして続行';

  @override
  String get forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get continueWithFacebook => 'Facebookで続行';

  @override
  String get continueWithGoogle => 'Googleで続行';

  @override
  String get noAccount => 'アカウントをお持ちでない場合？';

  @override
  String get signUpButton => 'サインアップ';

  @override
  String get signUpOrLogin => 'サインアップまたはログイン';

  @override
  String get guestMode => '現在、ゲストモードです';

  @override
  String get settings => '設定';

  @override
  String get changeAppLanguage => 'アプリの言語を変更';

  @override
  String get languageTitle => '言語';

  @override
  String get weekStartsOnTitle => '週の始まり';

  @override
  String get mondayLabel => '月曜日';

  @override
  String get sundayLabel => '日曜日';

  @override
  String get notifications => '通知';

  @override
  String get termsOfUse => '利用規約';

  @override
  String get termsOfUseTitle => '利用規約';

  @override
  String errorLoadingTerms(Object error) {
    return '規約の読み込み中にエラーが発生しました: $error';
  }

  @override
  String get languageSelectorTitle => '言語を選択';

  @override
  String get englishLanguage => '英語';

  @override
  String get vietnameseLanguage => 'ベトナム語';

  @override
  String get spanishLanguage => 'スペイン語';

  @override
  String get frenchLanguage => 'フランス語';

  @override
  String get chineseLanguage => '中国語';

  @override
  String get germanLanguage => 'ドイツ語';

  @override
  String get japaneseLanguage => '日本語';

  @override
  String get russianLanguage => 'ロシア語';

  @override
  String get hindiLanguage => 'ヒンディー語';

  @override
  String get koreanLanguage => '韓国語';

  @override
  String get createHabitTitle => '習慣を作成';

  @override
  String get editHabitTitle => '習慣を編集';

  @override
  String get habitNameLabel => '習慣名';

  @override
  String get noHabitsMessage => 'まだ習慣がありません。 \'+\'をタップして習慣を追加してください！';

  @override
  String get saveHabitButton => '習慣を保存';

  @override
  String repeatsEvery(String frequency) {
    return '$frequencyごとに繰り返す';
  }

  @override
  String get hasReminder => 'リマインダーあり';

  @override
  String get noReminder => 'リマインダーなし';

  @override
  String get selectCategoryLabel => 'カテゴリを選択';

  @override
  String get selectACategoryDefault => 'カテゴリを選択';

  @override
  String get selectDateLabel => '日付を選択';

  @override
  String get timeLabel => '時間';

  @override
  String get repeatLabel => '繰り返し';

  @override
  String get trackingTypeLabel => '追跡の種類';

  @override
  String get trackingTypeComplete => '完了';

  @override
  String get trackingTypeProgress => '進捗';

  @override
  String get categoryLabel => 'カテゴリ';

  @override
  String get dateLabel => '日付';

  @override
  String get timeViewLabel => '時間';

  @override
  String get repeatViewLabel => '繰り返し';

  @override
  String get reminderLabel => 'リマインダー';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return '目標: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => '単位';

  @override
  String get enableNotificationsLabel => '通知を有効にする';

  @override
  String get setProgressGoalDialogTitle => '進捗目標を設定';

  @override
  String get quantityLabel => '数量';

  @override
  String get unitLabel => '単位';

  @override
  String get updateProgressTitle => '進捗状況を更新';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => '繰り返しを選択';

  @override
  String get noRepeatLabel => '繰り返しなし';

  @override
  String get repeatDaily => '毎日';

  @override
  String get repeatWeekly => '毎週';

  @override
  String get repeatMonthly => '毎月';

  @override
  String get repeatYearly => '毎年';

  @override
  String get selectCategoryTitle => 'カテゴリを選択';

  @override
  String get categoryTitle => 'カテゴリ';

  @override
  String get othersLabel => 'その他';

  @override
  String get categoryHealth => '健康';

  @override
  String get categoryWork => '仕事';

  @override
  String get categoryPersonalGrowth => '自己成長';

  @override
  String get categoryHobby => '趣味';

  @override
  String get categoryFitness => 'フィットネス';

  @override
  String get categoryEducation => '教育';

  @override
  String get categoryFinance => 'お金';

  @override
  String get categorySocial => '社会';

  @override
  String get categorySpiritual => '精神性';

  @override
  String get totalHabits => '合計';

  @override
  String get completionRate => '達成率';

  @override
  String get completeHabits => '完了';

  @override
  String get progressHabits => '進行中';

  @override
  String get selectMonth => '月を選択';

  @override
  String get selectMonthTitle => '月を選択';

  @override
  String errorLoadingChartData(Object error) {
    return 'チャートデータの読み込み中にエラーが発生しました: $error';
  }

  @override
  String get noHabitDataMonth => 'この月の習慣データがありません';

  @override
  String get suggestionTitle => '最適化に関する提案';

  @override
  String get noSuggestionsAvailable => '現在、候補がありません。最適化のアイデアについては、後で確認してください！';

  @override
  String get aiRecommendationsFailedMessage => 'AIのおすすめを読み込めませんでした';

  @override
  String get tryAgainLaterMessage =>
      '提案システムとの接続に問題が発生しています。後で再試行するか、利用可能なプランをご覧ください。';

  @override
  String get suggestionLoadingTitle => 'おすすめの習慣を見てみましょう';

  @override
  String get suggestionLoadingDescription =>
      '最適化された習慣の提案は、あなたに合わせて調整されており、健康、生産性、マインドフルネス、学習など、さまざまなカテゴリにわたります。';

  @override
  String get filterAll => 'すべて';

  @override
  String get filterMostFrequent => '最も多い';

  @override
  String get filterTopPerformed => 'トップ実行';

  @override
  String noHabitsInCategory(String month) {
    return '$monthにはこのカテゴリの習慣がありません';
  }

  @override
  String get noRankedItemsAvailable => 'アイテムがありません';

  @override
  String get filterByCategoryLabel => 'カテゴリで絞り込む';

  @override
  String get filterByCategoryTitle => 'カテゴリで絞り込む';

  @override
  String get allCategoriesLabel => 'すべてのカテゴリ';

  @override
  String get noHabitsInCategoryMessage => 'このカテゴリには習慣が見つかりません';

  @override
  String get clearFilterTooltip => 'フィルターをクリア';

  @override
  String get showAllHabitsButton => 'すべての習慣を表示';

  @override
  String get addProgressTitle => '進捗を追加';

  @override
  String get enterProgressLabel => '値を入力してください';

  @override
  String get enterNumberEmptyError => '値を入力してください';

  @override
  String get enterNumberInvalidError => '有効な数値を入力してください';

  @override
  String get habitDeletedSuccess => '習慣が正常に削除されました！';

  @override
  String get habitDeleteFailed => '習慣の削除に失敗しました！';

  @override
  String get cannotRecordFutureHabit => '将来の日付に習慣を記録することはできません。';

  @override
  String get failedToUpdateHabit => '習慣の更新に失敗しました。もう一度お試しください。';

  @override
  String get failedToUpdateProgress => '進捗の更新に失敗しました。もう一度お試しください。';

  @override
  String get scopeDialogDefaultTitle => '変更を適用する…';

  @override
  String get deleteHabitDialogTitle => '習慣を削除しますか？';

  @override
  String get deleteHabitDialogMessage => 'この習慣を削除してもよろしいですか？';

  @override
  String get scopeOptionOnlyThis => 'この習慣のみ';

  @override
  String get scopeOptionThisAndFuture => 'この習慣と将来の習慣';

  @override
  String get scopeOptionAllInSeries => 'このシリーズのすべての習慣';

  @override
  String get themeSelectionTitle => '見た目';

  @override
  String get themeModeLight => 'ライト';

  @override
  String get themeModeDark => 'ダーク';

  @override
  String get themeModeSystem => 'デバイス設定を使用';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get applySelected => '選択適用';

  @override
  String get habitsApplied => '選択した提案が適用されました';

  @override
  String get habitAdded => '習慣が正常に追加されました';

  @override
  String get habitAddError => '習慣の追加に失敗しました';

  @override
  String get applySuggestion => '提案を適用する';

  @override
  String get appliedHabitsSuccessTitle => '成功！';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個の習慣が適用されました',
      one: '習慣が1つ適用されました',
      zero: '適用された習慣はありません',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription => 'これらの習慣は、あなたのルーティンの一部になりました。';

  @override
  String get backToSuggestionsButton => '提案に戻る';

  @override
  String get goToHomeButton => 'ホームへ';

  @override
  String get viewDetailsButton => '詳細を見る';

  @override
  String get appliedHabitsSummaryTitle => '適用された習慣';

  @override
  String get aiPicksTab => 'AIピック';

  @override
  String get habitPlansTab => '習慣プラン';

  @override
  String get exploreHabitPlans => '習慣プランを見る';

  @override
  String habitPlansError(Object error) {
    return '習慣プランの読み込み中にエラーが発生しました: $error';
  }

  @override
  String get aboutThisPlan => 'このプランについて';

  @override
  String get includedHabits => '含まれる習慣';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '#個の習慣を選択しました',
      one: '習慣を1つ選択しました',
      zero: '習慣を選択していません',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'インターネット接続がありません';

  @override
  String get noInternetConnectionDescription =>
      'インターネット接続を確認して、もう一度お試しください。オフラインでは一部の機能を利用できない場合があります。';

  @override
  String get retry => '再試行';

  @override
  String get viewOfflineContent => '利用可能なコンテンツを表示';

  @override
  String get personalizedSuggestionsWelcome => 'AIによるパーソナライズされた習慣提案';

  @override
  String get goalsHint => 'あなたの目標について教えてください…';

  @override
  String get personalityLabel => '性格';

  @override
  String get availableTimeLabel => '利用可能な時間';

  @override
  String get guidanceLevelLabel => 'ガイダンスレベル';

  @override
  String get selectPersonalityTitle => '性格を選択';

  @override
  String get selectAvailableTimeTitle => '利用可能な時間を選択';

  @override
  String get selectGuidanceLevelTitle => 'ガイダンスレベルを選択';

  @override
  String get selectDataSourceTitle => 'データソースを選択';

  @override
  String get personalityIntroverted => '内向的';

  @override
  String get personalityExtroverted => '外向的';

  @override
  String get personalityDisciplined => '規律のある';

  @override
  String get personalityCreative => '創造的な';

  @override
  String get personalityAnalytical => '分析的な';

  @override
  String get timeMorning => '午前';

  @override
  String get timeNoon => '正午';

  @override
  String get timeAfternoon => '午後';

  @override
  String get timeEvening => '夜';

  @override
  String get timeFlexible => '柔軟な';

  @override
  String get guidanceSimple => 'シンプル';

  @override
  String get guidanceIntermediate => '中級';

  @override
  String get guidanceAdvanced => '上級';

  @override
  String get dataSourcePersonalizationOnly => 'パーソナライズのみ';

  @override
  String get dataSourceHabitsOnly => '習慣のみ';

  @override
  String get dataSourceBoth => '両方';
}
