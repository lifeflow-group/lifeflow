// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'LifeFlow';

  @override
  String get loading => 'Đang tải...';

  @override
  String errorMessage(Object error) {
    return 'Lỗi: $error';
  }

  @override
  String get cancelButton => 'Hủy';

  @override
  String get saveButton => 'Lưu';

  @override
  String get selectButton => 'Chọn';

  @override
  String get refreshButton => 'Làm mới';

  @override
  String get deleteButton => 'Xóa';

  @override
  String get editButton => 'Sửa';

  @override
  String get noData => 'Không có dữ liệu';

  @override
  String get retryButton => 'Thử lại';

  @override
  String get orSeparator => 'hoặc';

  @override
  String get enabledLabel => 'Đã bật';

  @override
  String get disabledLabel => 'Đã tắt';

  @override
  String get okButton => 'Đồng ý';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navOverview => 'Tổng quan';

  @override
  String get navSuggestions => 'Gợi ý';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get loginTitle => 'Đăng nhập bằng Tài khoản';

  @override
  String get usernameHint => 'Tên người dùng / Email';

  @override
  String get passwordHint => 'Mật khẩu';

  @override
  String get loginButton => 'Đăng nhập';

  @override
  String get continueAsGuest => 'Tiếp tục với tư cách khách';

  @override
  String get forgotPassword => 'Quên mật khẩu?';

  @override
  String get continueWithFacebook => 'Tiếp tục với Facebook';

  @override
  String get continueWithGoogle => 'Tiếp tục với Google';

  @override
  String get noAccount => 'Chưa có tài khoản?';

  @override
  String get signUpButton => 'Đăng ký';

  @override
  String get signUpOrLogin => 'Đăng ký hoặc đăng nhập';

  @override
  String get guestMode => 'Bạn hiện đang ở chế độ khách';

  @override
  String get settings => 'Cài đặt';

  @override
  String get changeAppLanguage => 'Thay đổi ngôn ngữ ứng dụng';

  @override
  String get languageTitle => 'Ngôn ngữ';

  @override
  String get weekStartsOnTitle => 'Tuần bắt đầu vào';

  @override
  String get mondayLabel => 'Thứ Hai';

  @override
  String get sundayLabel => 'Chủ Nhật';

  @override
  String get notifications => 'Thông báo';

  @override
  String get termsOfUse => 'Điều khoản sử dụng';

  @override
  String get termsOfUseTitle => 'Điều khoản sử dụng';

  @override
  String errorLoadingTerms(Object error) {
    return 'Lỗi khi tải điều khoản: $error';
  }

  @override
  String get languageSelectorTitle => 'Chọn ngôn ngữ';

  @override
  String get englishLanguage => 'Tiếng Anh';

  @override
  String get vietnameseLanguage => 'Tiếng Việt';

  @override
  String get spanishLanguage => 'Tiếng Tây Ban Nha';

  @override
  String get frenchLanguage => 'Tiếng Pháp';

  @override
  String get chineseLanguage => 'Tiếng Trung';

  @override
  String get germanLanguage => 'Tiếng Đức';

  @override
  String get japaneseLanguage => 'Tiếng Nhật';

  @override
  String get russianLanguage => 'Tiếng Nga';

  @override
  String get hindiLanguage => 'Tiếng Hin-ddi';

  @override
  String get koreanLanguage => 'Tiếng Hàn';

  @override
  String get createHabitTitle => 'Tạo thói quen';

  @override
  String get editHabitTitle => 'Chỉnh sửa thói quen';

  @override
  String get habitNameLabel => 'Tên thói quen';

  @override
  String get noHabitsMessage =>
      'Chưa có thói quen nào. Nhấn \'+\' để thêm thói quen của bạn!';

  @override
  String get saveHabitButton => 'Lưu thói quen';

  @override
  String repeatsEvery(String frequency) {
    return 'Lặp lại mỗi $frequency';
  }

  @override
  String get hasReminder => 'Có lời nhắc';

  @override
  String get noReminder => 'Không có lời nhắc';

  @override
  String get selectCategoryLabel => 'Chọn danh mục';

  @override
  String get selectACategoryDefault => 'Chọn một danh mục';

  @override
  String get selectDateLabel => 'Chọn ngày';

  @override
  String get timeLabel => 'Thời gian';

  @override
  String get repeatLabel => 'Lặp lại';

  @override
  String get trackingTypeLabel => 'Loại theo dõi';

  @override
  String get trackingTypeComplete => 'Hoàn thành';

  @override
  String get trackingTypeProgress => 'Tiến độ';

  @override
  String get categoryLabel => 'Danh mục';

  @override
  String get dateLabel => 'Ngày';

  @override
  String get timeViewLabel => 'Thời gian';

  @override
  String get repeatViewLabel => 'Lặp lại';

  @override
  String get reminderLabel => 'Lời nhắc';

  @override
  String progressGoalLabel(Object targetValue, String unit) {
    return 'Mục tiêu: $targetValue $unit';
  }

  @override
  String get progressGoalUnitDefault => 'đơn vị';

  @override
  String get enableNotificationsLabel => 'Bật thông báo';

  @override
  String get setProgressGoalDialogTitle => 'Đặt mục tiêu tiến độ';

  @override
  String get quantityLabel => 'Số lượng';

  @override
  String get unitLabel => 'Đơn vị';

  @override
  String get updateProgressTitle => 'Cập nhật tiến độ';

  @override
  String progressFormat(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get selectRepeatSheetTitle => 'Chọn lặp lại';

  @override
  String get noRepeatLabel => 'Không lặp lại';

  @override
  String get repeatDaily => 'Hàng ngày';

  @override
  String get repeatWeekly => 'Hàng tuần';

  @override
  String get repeatMonthly => 'Hàng tháng';

  @override
  String get repeatYearly => 'Hàng năm';

  @override
  String get selectCategoryTitle => 'Chọn một danh mục';

  @override
  String get categoryTitle => 'Danh mục';

  @override
  String get othersLabel => 'Khác';

  @override
  String get categoryHealth => 'Sức khỏe';

  @override
  String get categoryWork => 'Công việc';

  @override
  String get categoryPersonalGrowth => 'Phát triển cá nhân';

  @override
  String get categoryHobby => 'Sở thích';

  @override
  String get categoryFitness => 'Thể dục';

  @override
  String get categoryEducation => 'Giáo dục';

  @override
  String get categoryFinance => 'Tài chính';

  @override
  String get categorySocial => 'Xã hội';

  @override
  String get categorySpiritual => 'Tinh thần';

  @override
  String get totalHabits => 'Tổng cộng';

  @override
  String get completionRate => 'Tỷ lệ';

  @override
  String get completeHabits => 'Hoàn thành';

  @override
  String get progressHabits => 'Đang tiến hành';

  @override
  String get selectMonth => 'Chọn tháng';

  @override
  String get selectMonthTitle => 'Chọn tháng';

  @override
  String errorLoadingChartData(Object error) {
    return 'Lỗi khi tải dữ liệu biểu đồ: $error';
  }

  @override
  String get noHabitDataMonth => 'Không có dữ liệu thói quen nào cho tháng này';

  @override
  String get suggestionTitle => 'Gợi ý tối ưu hóa';

  @override
  String get noSuggestionsAvailable =>
      'Hiện tại không có gợi ý nào. Vui lòng quay lại sau để xem các ý tưởng tối ưu hóa!';

  @override
  String get aiRecommendationsFailedMessage => 'Không thể tải đề xuất AI';

  @override
  String get tryAgainLaterMessage =>
      'Chúng tôi đang gặp sự cố khi kết nối với hệ thống đề xuất. Vui lòng thử lại sau hoặc khám phá các gói có sẵn.';

  @override
  String get suggestionLoadingTitle => 'Xem gợi ý nào';

  @override
  String get suggestionLoadingDescription =>
      'Gợi ý thói quen được tối ưu hóa của bạn được thiết kế riêng cho bạn và trải rộng nhiều danh mục như Sức khỏe, Năng suất, Chánh niệm, Học tập và hơn thế nữa.';

  @override
  String get filterAll => 'Tất cả';

  @override
  String get filterMostFrequent => 'Thường xuyên nhất';

  @override
  String get filterTopPerformed => 'Thực hiện tốt nhất';

  @override
  String noHabitsInCategory(String month) {
    return 'Chưa có thói quen nào trong danh mục này cho tháng $month';
  }

  @override
  String get noRankedItemsAvailable => 'Không có mục nào khả dụng';

  @override
  String get filterByCategoryLabel => 'Lọc theo danh mục';

  @override
  String get filterByCategoryTitle => 'Lọc theo danh mục';

  @override
  String get allCategoriesLabel => 'Tất cả danh mục';

  @override
  String get noHabitsInCategoryMessage =>
      'Không tìm thấy thói quen nào trong danh mục này';

  @override
  String get clearFilterTooltip => 'Xóa bộ lọc';

  @override
  String get showAllHabitsButton => 'Hiển thị tất cả thói quen';

  @override
  String get addProgressTitle => 'Thêm tiến độ';

  @override
  String get enterProgressLabel => 'Nhập giá trị';

  @override
  String get enterNumberEmptyError => 'Vui lòng nhập giá trị';

  @override
  String get enterNumberInvalidError => 'Vui lòng nhập số hợp lệ';

  @override
  String get habitDeletedSuccess => 'Xóa thói quen thành công!';

  @override
  String get habitDeleteFailed => 'Xóa thói quen thất bại!';

  @override
  String get cannotRecordFutureHabit =>
      'Không thể ghi lại thói quen cho ngày trong tương lai.';

  @override
  String get failedToUpdateHabit =>
      'Cập nhật thói quen thất bại. Vui lòng thử lại.';

  @override
  String get failedToUpdateProgress =>
      'Cập nhật tiến độ thất bại. Vui lòng thử lại.';

  @override
  String get scopeDialogDefaultTitle => 'Áp dụng thay đổi cho...';

  @override
  String get deleteHabitDialogTitle => 'Xóa thói quen?';

  @override
  String get deleteHabitDialogMessage =>
      'Bạn có chắc chắn muốn xóa thói quen này không?';

  @override
  String get scopeOptionOnlyThis => 'Chỉ thói quen này';

  @override
  String get scopeOptionThisAndFuture =>
      'Thói quen này và các thói quen trong tương lai';

  @override
  String get scopeOptionAllInSeries => 'Tất cả các thói quen trong chuỗi này';

  @override
  String get themeSelectionTitle => 'Giao diện';

  @override
  String get themeModeLight => 'Sáng';

  @override
  String get themeModeDark => 'Tối';

  @override
  String get themeModeSystem => 'Sử dụng cài đặt thiết bị';

  @override
  String get selectAll => 'Chọn tất cả';

  @override
  String get applySelected => 'Áp dụng mục đã chọn';

  @override
  String get habitsApplied => 'Đã áp dụng các đề xuất đã chọn';

  @override
  String get habitAdded => 'Thêm thói quen thành công';

  @override
  String get habitAddError => 'Thêm thói quen không thành công';

  @override
  String get applySuggestion => 'Áp dụng đề xuất';

  @override
  String get appliedHabitsSuccessTitle => 'Thành công!';

  @override
  String appliedHabitsCountMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã áp dụng $count thói quen',
      one: 'Đã áp dụng 1 thói quen',
      zero: 'Chưa áp dụng thói quen nào',
    );
    return '$_temp0';
  }

  @override
  String get appliedHabitsDescription =>
      'Những thói quen này giờ đây là một phần trong thói quen hàng ngày của bạn.';

  @override
  String get backToSuggestionsButton => 'Trở lại gợi ý';

  @override
  String get goToHomeButton => 'Về Trang chủ';

  @override
  String get viewDetailsButton => 'Xem chi tiết';

  @override
  String get appliedHabitsSummaryTitle => 'Thói quen đã áp dụng';

  @override
  String get aiPicksTab => 'Lựa chọn của AI';

  @override
  String get habitPlansTab => 'Kế hoạch hình thành thói quen';

  @override
  String get exploreHabitPlans => 'Duyệt Kế hoạch hình thành thói quen';

  @override
  String habitPlansError(Object error) {
    return 'Lỗi khi tải kế hoạch hình thành thói quen: $error';
  }

  @override
  String get aboutThisPlan => 'Về kế hoạch này';

  @override
  String get includedHabits => 'Các thói quen được bao gồm';

  @override
  String habitsSelectedText(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Đã chọn $count thói quen',
      one: 'Đã chọn 1 thói quen',
      zero: 'Chưa chọn thói quen nào',
    );
    return '$_temp0';
  }

  @override
  String get noInternetConnection => 'Không có kết nối internet';

  @override
  String get noInternetConnectionDescription =>
      'Vui lòng kiểm tra kết nối internet của bạn và thử lại. Một số tính năng có thể không khả dụng khi ngoại tuyến.';

  @override
  String get retry => 'Thử lại';

  @override
  String get viewOfflineContent => 'Xem nội dung khả dụng';

  @override
  String get personalizedSuggestionsWelcome => 'Gợi ý thói quen AI cá nhân hóa';

  @override
  String get goalsHint => 'Hãy cho tôi biết về mục tiêu của bạn...';

  @override
  String get personalityLabel => 'Cá tính';

  @override
  String get availableTimeLabel => 'Thời gian khả dụng';

  @override
  String get guidanceLevelLabel => 'Mức độ hướng dẫn';

  @override
  String get selectPersonalityTitle => 'Chọn Cá tính';

  @override
  String get selectAvailableTimeTitle => 'Chọn Thời gian khả dụng';

  @override
  String get selectGuidanceLevelTitle => 'Chọn Mức độ hướng dẫn';

  @override
  String get selectDataSourceTitle => 'Chọn Nguồn dữ liệu';

  @override
  String get personalityIntroverted => 'Nội tâm';

  @override
  String get personalityExtroverted => 'Ngoại hướng';

  @override
  String get personalityDisciplined => 'Kỷ luật';

  @override
  String get personalityCreative => 'Sáng tạo';

  @override
  String get personalityAnalytical => 'Phân tích';

  @override
  String get timeMorning => 'Buổi sáng';

  @override
  String get timeNoon => 'Buổi trưa';

  @override
  String get timeAfternoon => 'Buổi chiều';

  @override
  String get timeEvening => 'Buổi tối';

  @override
  String get timeFlexible => 'Linh hoạt';

  @override
  String get guidanceSimple => 'Đơn giản';

  @override
  String get guidanceIntermediate => 'Trung cấp';

  @override
  String get guidanceAdvanced => 'Nâng cao';

  @override
  String get dataSourcePersonalizationOnly => 'Chỉ cá nhân hóa';

  @override
  String get dataSourceHabitsOnly => 'Chỉ thói quen';

  @override
  String get dataSourceBoth => 'Cả hai';
}
