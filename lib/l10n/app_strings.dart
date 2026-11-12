class AppStrings {
  static const Map<String, Map<String, String>> _data = {
    'vi': {
      'nav_home': 'Trang chủ',
      'nav_decks': 'Bộ thẻ',
      'nav_settings': 'Cài đặt',
      'greeting': 'Xin chào! 👋',
      'greeting_sub': 'Hôm nay học thêm vài từ nhé.',
      'progress_title': 'Tiến độ học',
      'learned_count': 'Đã thuộc {a} / {b} từ',
      'decks_label': 'Bộ thẻ',
      'total_words': 'Tổng số từ',
      'quick_study': 'Học nhanh',
      'quick_soon': 'Tính năng học nhanh sẽ có sau!',
      'settings_title': 'Cài đặt',
      'language': 'Ngôn ngữ',
      'lang_vi': 'Tiếng Việt',
      'lang_en': 'English',
      'appearance': 'Giao diện',
      'dark_mode': 'Chế độ tối',
      'dark_mode_sub': 'Bật giao diện nền tối',
    },
    'en': {
      'nav_home': 'Home',
      'nav_decks': 'Decks',
      'nav_settings': 'Settings',
      'greeting': 'Hello! 👋',
      'greeting_sub': 'Let\'s learn a few new words today.',
      'progress_title': 'Learning progress',
      'learned_count': 'Learned {a} / {b} words',
      'decks_label': 'Decks',
      'total_words': 'Total words',
      'quick_study': 'Quick study',
      'quick_soon': 'Quick study is coming soon!',
      'settings_title': 'Settings',
      'language': 'Language',
      'lang_vi': 'Tiếng Việt',
      'lang_en': 'English',
      'appearance': 'Appearance',
      'dark_mode': 'Dark mode',
      'dark_mode_sub': 'Use a dark background',
    },
  };

  static String get(String lang, String key, [Map<String, String>? params]) {
    var text = _data[lang]?[key] ?? _data['en']?[key] ?? key;
    params?.forEach((k, v) => text = text.replaceAll('{$k}', v));
    return text;
  }
}
