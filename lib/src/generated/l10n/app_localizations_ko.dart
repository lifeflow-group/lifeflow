// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => '로드 중...';

  @override
  String errorMessage(Object error) {
    return '오류: $error';
  }

  @override
  String get cancelButton => '취소';

  @override
  String get saveButton => '저장';

  @override
  String get selectButton => '선택';

  @override
  String get refreshButton => '새로 고침';

  @override
  String get deleteButton => '삭제';

  @override
  String get editButton => '편집';

  @override
  String get noData => '데이터가 없습니다';

  @override
  String get retryButton => '다시 시도';

  @override
  String get orSeparator => '또는';

  @override
  String get enabledLabel => '활성화됨';

  @override
  String get disabledLabel => '비활성화됨';

  @override
  String get okButton => '확인';

  @override
  String get navHome => '홈';

  @override
  String get navOverview => '개요';

  @override
  String get navSuggestions => '제안';

  @override
  String get navSettings => '설정';

  @override
  String get loginTitle => '계정으로 로그인';

  @override
  String get usernameHint => '사용자 이름/이메일';

  @override
  String get passwordHint => '비밀번호';

  @override
  String get loginButton => '로그인';

  @override
  String get continueAsGuest => '게스트로 계속';

  @override
  String get forgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get continueWithFacebook => '페이스북으로 계속';

  @override
  String get continueWithGoogle => '구글로 계속';

  @override
  String get noAccount => '계정이 없으세요?';

  @override
  String get signUpButton => '가입';

  @override
  String get signUpOrLogin => '가입 또는 로그인';

  @override
  String get guestMode => '현재 게스트 모드입니다';

  @override
  String get settings => '설정';

  @override
  String get changeAppLanguage => '앱 언어 변경';

  @override
  String get languageTitle => '언어';

  @override
  String get weekStartsOnTitle => '주 시작 요일';

  @override
  String get mondayLabel => '월요일';

  @override
  String get sundayLabel => '일요일';

  @override
  String get notifications => '알림';

  @override
  String get termsOfUse => '이용 약관';

  @override
  String get termsOfUseTitle => '이용 약관';

  @override
  String errorLoadingTerms(Object error) {
    return '약관 로드 중 오류 발생: $error';
  }

  @override
  String get languageSelectorTitle => '언어 선택';

  @override
  String get englishLanguage => '영어';

  @override
  String get vietnameseLanguage => '베트남어';

  @override
  String get spanishLanguage => '스페인어';

  @override
  String get frenchLanguage => '프랑스어';

  @override
  String get chineseLanguage => '중국어';

  @override
  String get germanLanguage => '독일어';

  @override
  String get japaneseLanguage => '일본어';

  @override
  String get russianLanguage => '러시아어';

  @override
  String get hindiLanguage => '힌디어';

  @override
  String get koreanLanguage => '한국어';

  @override
  String get createHabitTitle => '습관 만들기';

  @override
  String get editHabitTitle => '습관 편집';

  @override
  String get habitNameLabel => '습관 이름';

  @override
  String get noHabitsMessage => '아직 습관이 없습니다. \'+\'를 눌러 습관을 추가하세요!';

  @override
  String get saveHabitButton => '습관 저장';

  @override
  String repeatsEvery(String frequency) {
    return '$frequency마다 반복';
  }

  @override
  String get hasReminder => '알림 있음';

  @override
  String get noReminder => '알림 없음';

  @override
  String get selectCategoryLabel => '카테고리 선택';

  @override
  String get selectACategoryDefault => '카테고리 선택';

  @override
  String get selectDateLabel => '날짜 선택';

  @override
  String get timeLabel => '시간';

  @override
  String get repeatLabel => '반복';

  @override
  String get trackingTypeLabel => '추적 유형';

  @override
  String get trackingTypeComplete => '완료';

  @override
  String get trackingTypeProgress => '진행률';

  @override
  String get categoryLabel => '카테고리';

  @override
  String get dateLabel => '날짜';

  @override
  String get timeViewLabel => '시간';

  @override
  String get repeatViewLabel => '반복';

  @override
  String get reminderLabel => '알림';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return '목표: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => '단위';

  @override
  String get enableNotificationsLabel => '알림 활성화';

  @override
  String get setProgressGoalDialogTitle => '진행률 목표 설정';

  @override
  String get quantityLabel => '수량';

  @override
  String get unitLabel => '단위';

  @override
  String get updateProgressTitle => '진행률 업데이트';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => '반복 선택';

  @override
  String get noRepeatLabel => '반복 없음';

  @override
  String get repeatDaily => '매일';

  @override
  String get repeatWeekly => '매주';

  @override
  String get repeatMonthly => '매달';

  @override
  String get repeatYearly => '매년';

  @override
  String get selectCategoryTitle => '카테고리 선택';

  @override
  String get categoryTitle => '카테고리';

  @override
  String get othersLabel => '기타';

  @override
  String get categoryHealth => '건강';

  @override
  String get categoryWork => '업무';

  @override
  String get categoryPersonalGrowth => '자기 계발';

  @override
  String get categoryHobby => '취미';

  @override
  String get categoryFitness => '피트니스';

  @override
  String get categoryEducation => '교육';

  @override
  String get categoryFinance => '재정';

  @override
  String get categorySocial => '사회';

  @override
  String get categorySpiritual => '정신적';

  @override
  String get totalHabits => '총계';

  @override
  String get completionRate => '비율';

  @override
  String get completeHabits => '완료';

  @override
  String get progressHabits => '진행 중';

  @override
  String get selectMonth => '월 선택';

  @override
  String get selectMonthTitle => '월 선택';

  @override
  String errorLoadingChartData(Object error) {
    return '차트 데이터 로드 중 오류 발생: $error';
  }

  @override
  String get noHabitDataMonth => '이번 달의 습관 데이터가 없습니다';

  @override
  String get suggestionTitle => '최적화 제안';

  @override
  String get noSuggestionsAvailable => '현재 제안이 없습니다. 나중에 최적화 아이디어를 확인해 보세요!';

  @override
  String get aiRecommendationsFailedMessage => 'AI 추천을 불러올 수 없습니다.';

  @override
  String get tryAgainLaterMessage =>
      '추천 시스템 연결에 문제가 있습니다. 나중에 다시 시도하거나, 현재 이용 가능한 플랜을 살펴보세요.';

  @override
  String get suggestionLoadingTitle => '추천을 확인해 보세요';

  @override
  String get suggestionLoadingDescription =>
      '건강, 생산성, 마음 챙김, 학습 등 여러 범주에 걸쳐 사용자에게 맞춤화된 최적의 습관 제안을 확인할 수 있습니다.';

  @override
  String get filterAll => '전체';

  @override
  String get filterMostFrequent => '가장 빈번한';

  @override
  String get filterTopPerformed => '최고 성과';

  @override
  String noHabitsInCategory(String month) {
    return '$month에는 해당 범주에 습관이 없습니다.';
  }

  @override
  String get noRankedItemsAvailable => '사용 가능한 항목이 없습니다';

  @override
  String get filterByCategoryLabel => '카테고리로 필터링';

  @override
  String get filterByCategoryTitle => '카테고리로 필터링';

  @override
  String get allCategoriesLabel => '모든 카테고리';

  @override
  String get noHabitsInCategoryMessage => '이 카테고리에 해당하는 습관이 없습니다';

  @override
  String get clearFilterTooltip => '필터 지우기';

  @override
  String get showAllHabitsButton => '모든 습관 보기';

  @override
  String get addProgressTitle => '진행 상황 추가';

  @override
  String get enterProgressLabel => '값을 입력하세요';

  @override
  String get enterNumberEmptyError => '값을 입력하세요.';

  @override
  String get enterNumberInvalidError => '올바른 숫자를 입력하세요.';

  @override
  String get habitDeletedSuccess => '습관이 성공적으로 삭제되었습니다!';

  @override
  String get habitDeleteFailed => '습관 삭제에 실패했습니다!';

  @override
  String get cannotRecordFutureHabit => '미래 날짜에 대한 습관을 기록할 수 없습니다.';

  @override
  String get failedToUpdateHabit => '습관 업데이트에 실패했습니다. 다시 시도하세요.';

  @override
  String get failedToUpdateProgress => '진행 상황 업데이트에 실패했습니다. 다시 시도하세요.';

  @override
  String get scopeDialogDefaultTitle => '변경 사항 적용 대상...';

  @override
  String get deleteHabitDialogTitle => '습관 삭제?';

  @override
  String get deleteHabitDialogMessage => '이 습관을 삭제하시겠습니까?';

  @override
  String get scopeOptionOnlyThis => '이 습관만';

  @override
  String get scopeOptionThisAndFuture => '이 습관과 미래 습관';

  @override
  String get scopeOptionAllInSeries => '이 시리즈의 모든 습관';

  @override
  String get themeSelectionTitle => '모양';

  @override
  String get themeModeLight => '밝게';

  @override
  String get themeModeDark => '어둡게';

  @override
  String get themeModeSystem => '기기 설정 사용';

  @override
  String get selectAll => '모두 선택';

  @override
  String get applySelected => '선택 적용';

  @override
  String get habitsApplied => '선택한 제안이 적용되었습니다.';

  @override
  String get habitAdded => '습관이 성공적으로 추가되었습니다.';

  @override
  String get habitAddError => '습관 추가에 실패했습니다.';

  @override
  String get applySuggestion => '제안 적용';

  @override
  String get appliedHabitsSuccessTitle => '성공!';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 습관 성공적으로 적용됨',
      one: '습관 1개 성공적으로 적용됨',
      zero: '적용된 습관 없음',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription => '이 습관들은 이제 당신의 일상의 일부입니다.';

  @override
  String get backToSuggestionsButton => '제안으로 돌아가기';

  @override
  String get goToHomeButton => '홈으로 이동';

  @override
  String get viewDetailsButton => '자세히 보기';

  @override
  String get appliedHabitsSummaryTitle => '적용된 습관';

  @override
  String get aiPicksTab => 'AI 추천';

  @override
  String get habitPlansTab => '습관 계획';

  @override
  String get exploreHabitPlans => '습관 계획 찾아보기';

  @override
  String habitPlansError(Object error) {
    return '습관 계획을 불러오는 중 오류가 발생했습니다: $error';
  }

  @override
  String get aboutThisPlan => '이 계획 정보';

  @override
  String get includedHabits => '포함된 습관';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '#개의 습관 선택됨',
      one: '습관 1개 선택됨',
      zero: '선택된 습관 없음',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => '인터넷 연결이 없습니다';

  @override
  String get noInternetConnectionDescription =>
      '인터넷 연결 상태를 확인하고 다시 시도해주세요. 일부 기능은 오프라인 상태에서는 사용할 수 없습니다.';

  @override
  String get retry => '다시 시도';

  @override
  String get viewOfflineContent => '사용 가능한 콘텐츠 보기';

  @override
  String get personalizedSuggestionsWelcome => 'AI 맞춤 습관 제안';

  @override
  String get goalsHint => '목표에 대해 알려주세요...';

  @override
  String get personalityLabel => '성격';

  @override
  String get availableTimeLabel => '사용 가능 시간';

  @override
  String get guidanceLevelLabel => '지침 수준';

  @override
  String get selectPersonalityTitle => '성격 선택';

  @override
  String get selectAvailableTimeTitle => '사용 가능 시간 선택';

  @override
  String get selectGuidanceLevelTitle => '지침 수준 선택';

  @override
  String get selectDataSourceTitle => '데이터 소스 선택';

  @override
  String get personalityIntroverted => '내향적인';

  @override
  String get personalityExtroverted => '외향적인';

  @override
  String get personalityDisciplined => '규율 있는';

  @override
  String get personalityCreative => '창의적인';

  @override
  String get personalityAnalytical => '분석적인';

  @override
  String get timeMorning => '오전';

  @override
  String get timeNoon => '정오';

  @override
  String get timeAfternoon => '오후';

  @override
  String get timeEvening => '저녁';

  @override
  String get timeFlexible => '융통성 있는';

  @override
  String get guidanceSimple => '간단한';

  @override
  String get guidanceIntermediate => '중급';

  @override
  String get guidanceAdvanced => '고급';

  @override
  String get dataSourcePersonalizationOnly => '개인 설정만';

  @override
  String get dataSourceHabitsOnly => '습관만';

  @override
  String get dataSourceBoth => '둘 다';
}
