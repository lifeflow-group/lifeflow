// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => '加载中...';

  @override
  String errorMessage(Object error) {
    return '错误：$error';
  }

  @override
  String get cancelButton => '取消';

  @override
  String get saveButton => '保存';

  @override
  String get selectButton => '选择';

  @override
  String get refreshButton => '刷新';

  @override
  String get deleteButton => '删除';

  @override
  String get editButton => '编辑';

  @override
  String get noData => '没有数据';

  @override
  String get retryButton => '重试';

  @override
  String get orSeparator => '或';

  @override
  String get enabledLabel => '已启用';

  @override
  String get disabledLabel => '已禁用';

  @override
  String get okButton => '确定';

  @override
  String get navHome => '首页';

  @override
  String get navOverview => '概览';

  @override
  String get navSuggestions => '建议';

  @override
  String get navSettings => '设置';

  @override
  String get loginTitle => '使用账户登录';

  @override
  String get usernameHint => '用户名/邮箱';

  @override
  String get passwordHint => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get continueAsGuest => '继续作为访客';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get continueWithFacebook => '使用Facebook继续';

  @override
  String get continueWithGoogle => '使用Google继续';

  @override
  String get noAccount => '没有账户？';

  @override
  String get signUpButton => '注册';

  @override
  String get signUpOrLogin => '注册或登录';

  @override
  String get guestMode => '您目前处于访客模式';

  @override
  String get settings => '设置';

  @override
  String get changeAppLanguage => '更改应用语言';

  @override
  String get languageTitle => '语言';

  @override
  String get weekStartsOnTitle => '一周从哪一天开始';

  @override
  String get mondayLabel => '星期一';

  @override
  String get sundayLabel => '星期天';

  @override
  String get notifications => '通知';

  @override
  String get termsOfUse => '使用条款';

  @override
  String get termsOfUseTitle => '使用条款';

  @override
  String errorLoadingTerms(Object error) {
    return '加载条款时出错：$error';
  }

  @override
  String get languageSelectorTitle => '选择语言';

  @override
  String get englishLanguage => '英语';

  @override
  String get vietnameseLanguage => '越南语';

  @override
  String get spanishLanguage => '西班牙语';

  @override
  String get frenchLanguage => '法语';

  @override
  String get chineseLanguage => '中文';

  @override
  String get germanLanguage => '德语';

  @override
  String get japaneseLanguage => '日语';

  @override
  String get russianLanguage => '俄语';

  @override
  String get hindiLanguage => '印地语';

  @override
  String get koreanLanguage => '韩语';

  @override
  String get createHabitTitle => '创建习惯';

  @override
  String get editHabitTitle => '编辑习惯';

  @override
  String get habitNameLabel => '习惯名称';

  @override
  String get noHabitsMessage => '还没有习惯。点击“+”添加您的习惯！';

  @override
  String get saveHabitButton => '保存习惯';

  @override
  String repeatsEvery(String frequency) {
    return '每$frequency重复一次';
  }

  @override
  String get hasReminder => '有提醒';

  @override
  String get noReminder => '无提醒';

  @override
  String get selectCategoryLabel => '选择类别';

  @override
  String get selectACategoryDefault => '选择一个类别';

  @override
  String get selectDateLabel => '选择日期';

  @override
  String get timeLabel => '时间';

  @override
  String get repeatLabel => '重复';

  @override
  String get trackingTypeLabel => '追踪类型';

  @override
  String get trackingTypeComplete => '完成';

  @override
  String get trackingTypeProgress => '进度';

  @override
  String get categoryLabel => '类别';

  @override
  String get dateLabel => '日期';

  @override
  String get timeViewLabel => '时间';

  @override
  String get repeatViewLabel => '重复';

  @override
  String get reminderLabel => '提醒';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return '目标：$targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => '单位';

  @override
  String get enableNotificationsLabel => '启用通知';

  @override
  String get setProgressGoalDialogTitle => '设置进度目标';

  @override
  String get quantityLabel => '数量';

  @override
  String get unitLabel => '单位';

  @override
  String get updateProgressTitle => '更新进度';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => '选择重复';

  @override
  String get noRepeatLabel => '不重复';

  @override
  String get repeatDaily => '每日';

  @override
  String get repeatWeekly => '每周';

  @override
  String get repeatMonthly => '每月';

  @override
  String get repeatYearly => '每年';

  @override
  String get selectCategoryTitle => '选择类别';

  @override
  String get categoryTitle => '类别';

  @override
  String get othersLabel => '其他';

  @override
  String get categoryHealth => '健康';

  @override
  String get categoryWork => '工作';

  @override
  String get categoryPersonalGrowth => '个人成长';

  @override
  String get categoryHobby => '爱好';

  @override
  String get categoryFitness => '健身';

  @override
  String get categoryEducation => '教育';

  @override
  String get categoryFinance => '理财';

  @override
  String get categorySocial => '社交';

  @override
  String get categorySpiritual => '精神';

  @override
  String get totalHabits => '总数';

  @override
  String get completionRate => '完成率';

  @override
  String get completeHabits => '已完成';

  @override
  String get progressHabits => '进行中';

  @override
  String get selectMonth => '选择月份';

  @override
  String get selectMonthTitle => '选择月份';

  @override
  String errorLoadingChartData(Object error) {
    return '加载图表数据时出错：$error';
  }

  @override
  String get noHabitDataMonth => '本月没有习惯数据';

  @override
  String get suggestionTitle => '优化建议';

  @override
  String get noSuggestionsAvailable => '目前没有可用的建议。请稍后再查看以获取优化建议！';

  @override
  String get aiRecommendationsFailedMessage => '无法加载 AI 建议';

  @override
  String get tryAgainLaterMessage => '我们正在连接建议系统时遇到问题。请稍后再试或浏览可用方案。';

  @override
  String get suggestionLoadingTitle => '看看建议';

  @override
  String get suggestionLoadingDescription =>
      '您的个性化习惯建议经过优化，涵盖健康、效率、正念、学习等多个类别。';

  @override
  String get filterAll => '全部';

  @override
  String get filterMostFrequent => '最常发生';

  @override
  String get filterTopPerformed => '最佳表现';

  @override
  String noHabitsInCategory(String month) {
    return '此类别中$month没有习惯';
  }

  @override
  String get noRankedItemsAvailable => '没有可用的项目';

  @override
  String get filterByCategoryLabel => '按类别筛选';

  @override
  String get filterByCategoryTitle => '按类别筛选';

  @override
  String get allCategoriesLabel => '所有类别';

  @override
  String get noHabitsInCategoryMessage => '此类别中没有习惯';

  @override
  String get clearFilterTooltip => '清除筛选';

  @override
  String get showAllHabitsButton => '显示所有习惯';

  @override
  String get addProgressTitle => '添加进度';

  @override
  String get enterProgressLabel => '输入数值';

  @override
  String get enterNumberEmptyError => '请输入数值';

  @override
  String get enterNumberInvalidError => '请输入有效数字';

  @override
  String get habitDeletedSuccess => '习惯已成功删除！';

  @override
  String get habitDeleteFailed => '删除习惯失败！';

  @override
  String get cannotRecordFutureHabit => '无法记录未来日期的习惯。';

  @override
  String get failedToUpdateHabit => '更新习惯失败。请重试。';

  @override
  String get failedToUpdateProgress => '更新进度失败。请重试。';

  @override
  String get scopeDialogDefaultTitle => '将更改应用于...';

  @override
  String get deleteHabitDialogTitle => '删除习惯？';

  @override
  String get deleteHabitDialogMessage => '您确定要删除此习惯吗？';

  @override
  String get scopeOptionOnlyThis => '仅此习惯';

  @override
  String get scopeOptionThisAndFuture => '此习惯及未来的习惯';

  @override
  String get scopeOptionAllInSeries => '此系列中的所有习惯';

  @override
  String get themeSelectionTitle => '外观';

  @override
  String get themeModeLight => '浅色';

  @override
  String get themeModeDark => '深色';

  @override
  String get themeModeSystem => '使用设备设置';

  @override
  String get selectAll => '全选';

  @override
  String get applySelected => '应用已选';

  @override
  String get habitsApplied => '已应用选定的建议';

  @override
  String get habitAdded => '习惯添加成功';

  @override
  String get habitAddError => '添加习惯失败';

  @override
  String get applySuggestion => '应用建议';

  @override
  String get appliedHabitsSuccessTitle => '成功！';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已成功应用$count个习惯',
      one: '已成功应用1个习惯',
      zero: '未应用任何习惯',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription => '这些习惯现在已成为您日常生活的一部分。';

  @override
  String get backToSuggestionsButton => '返回建议';

  @override
  String get goToHomeButton => '去首页';

  @override
  String get viewDetailsButton => '查看详情';

  @override
  String get appliedHabitsSummaryTitle => '已应用的习惯';

  @override
  String get aiPicksTab => 'AI精选';

  @override
  String get habitPlansTab => '习惯计划';

  @override
  String get exploreHabitPlans => '浏览习惯计划';

  @override
  String habitPlansError(Object error) {
    return '加载习惯计划时出错：$error';
  }

  @override
  String get aboutThisPlan => '关于此计划';

  @override
  String get includedHabits => '包含的习惯';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已选择$count个习惯',
      one: '已选择1个习惯',
      zero: '未选择任何习惯',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => '无网络连接';

  @override
  String get noInternetConnectionDescription => '请检查您的网络连接，然后重试。某些功能可能无法离线使用。';

  @override
  String get retry => '重试';

  @override
  String get viewOfflineContent => '查看可用内容';

  @override
  String get personalizedSuggestionsWelcome => '个性化 AI 习惯建议';

  @override
  String get goalsHint => '告诉我您的目标…';

  @override
  String get personalityLabel => '个性';

  @override
  String get availableTimeLabel => '可用时间';

  @override
  String get guidanceLevelLabel => '指导级别';

  @override
  String get selectPersonalityTitle => '选择个性';

  @override
  String get selectAvailableTimeTitle => '选择可用时间';

  @override
  String get selectGuidanceLevelTitle => '选择指导级别';

  @override
  String get selectDataSourceTitle => '选择数据源';

  @override
  String get personalityIntroverted => '内向型';

  @override
  String get personalityExtroverted => '外向型';

  @override
  String get personalityDisciplined => '自律型';

  @override
  String get personalityCreative => '创意型';

  @override
  String get personalityAnalytical => '分析型';

  @override
  String get timeMorning => '上午';

  @override
  String get timeNoon => '中午';

  @override
  String get timeAfternoon => '下午';

  @override
  String get timeEvening => '晚上';

  @override
  String get timeFlexible => '灵活';

  @override
  String get guidanceSimple => '简单';

  @override
  String get guidanceIntermediate => '中等';

  @override
  String get guidanceAdvanced => '高级';

  @override
  String get dataSourcePersonalizationOnly => '仅个性化';

  @override
  String get dataSourceHabitsOnly => '仅习惯';

  @override
  String get dataSourceBoth => '两者兼有';
}
