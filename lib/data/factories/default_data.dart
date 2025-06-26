import '../domain/models/category.dart';
import '../domain/models/habit.dart';
import '../domain/models/habit_plan.dart';
import '../domain/models/habit_series.dart';
import '../domain/models/suggestion.dart';
import 'model_factories.dart';

/// Default categories for habit plans
final List<Category> defaultPlanCategories = [
  Category((b) => b
    ..id = "health_wellness"
    ..name = "Health & Wellness"
    ..iconPath = "assets/icons/health_wellness.png"
    ..colorHex = "#4CAF50"), // Green
  Category((b) => b
    ..id = "productivity"
    ..name = "Productivity"
    ..iconPath = "assets/icons/productivity.png"
    ..colorHex = "#2196F3"), // Blue
  Category((b) => b
    ..id = "personal_growth"
    ..name = "Personal Growth"
    ..iconPath = "assets/icons/personal_growth.png"
    ..colorHex = "#9C27B0"), // Purple
  Category((b) => b
    ..id = "mindfulness"
    ..name = "Mindfulness"
    ..iconPath = "assets/icons/mindfulness.png"
    ..colorHex = "#FF9800"), // Orange
  Category((b) => b
    ..id = "fitness"
    ..name = "Fitness"
    ..iconPath = "assets/icons/fitness.png"
    ..colorHex = "#F44336"), // Red
  Category((b) => b
    ..id = "diet_nutrition"
    ..name = "Diet & Nutrition"
    ..iconPath = "assets/icons/diet_nutrition.png"
    ..colorHex = "#8BC34A"), // Light Green
  Category((b) => b
    ..id = "sleep"
    ..name = "Sleep"
    ..iconPath = "assets/icons/sleep.png"
    ..colorHex = "#673AB7"), // Deep Purple
  Category((b) => b
    ..id = "work_life_balance"
    ..name = "Work-Life Balance"
    ..iconPath = "assets/icons/work_life_balance.png"
    ..colorHex = "#00BCD4"), // Cyan
];

/// Default categories for regular habits
final List<Category> defaultCategories = [
  Category((b) => b
    ..id = "health"
    ..name = "Health"
    ..iconPath = "assets/icons/health.png"
    ..colorHex = "#FF5733"), // Reddish orange
  Category((b) => b
    ..id = "work"
    ..name = "Work"
    ..iconPath = "assets/icons/work.png"
    ..colorHex = "#3498DB"), // Blue
  Category((b) => b
    ..id = "personal_growth"
    ..name = "Personal Growth"
    ..iconPath = "assets/icons/personal_growth.png"
    ..colorHex = "#9B59B6"), // Purple
  Category((b) => b
    ..id = "hobby"
    ..name = "Hobby"
    ..iconPath = "assets/icons/hobby.png"
    ..colorHex = "#F1C40F"), // Yellow
  Category((b) => b
    ..id = "fitness"
    ..name = "Fitness"
    ..iconPath = "assets/icons/fitness.png"
    ..colorHex = "#2ECC71"), // Green
  Category((b) => b
    ..id = "education"
    ..name = "Education"
    ..iconPath = "assets/icons/education.png"
    ..colorHex = "#E67E22"), // Orange
  Category((b) => b
    ..id = "finance"
    ..name = "Finance"
    ..iconPath = "assets/icons/finance.png"
    ..colorHex = "#27AE60"), // Dark Green
  Category((b) => b
    ..id = "social"
    ..name = "Social"
    ..iconPath = "assets/icons/social.png"
    ..colorHex = "#E74C3C"), // Red
  Category((b) => b
    ..id = "spiritual"
    ..name = "Spiritual"
    ..iconPath = "assets/icons/spiritual.png"
    ..colorHex = "#8E44AD"), // Dark Purple
];

/// Find a category by ID from default categories
Category? getCategoryById(String id) {
  try {
    return defaultCategories.firstWhere((category) => category.id == id);
  } catch (e) {
    return null;
  }
}

/// Find a plan category by ID from default plan categories
Category? getPlanCategoryById(String id) {
  try {
    return defaultPlanCategories.firstWhere((category) => category.id == id);
  } catch (e) {
    return null;
  }
}

/// Generates a list of mock habit plans for demonstration purposes.
List<HabitPlan> getMockHabitPlans() {
  // Get categories from the existing list
  final healthWellnessCategory = defaultPlanCategories.firstWhere(
      (cat) => cat.id == "health_wellness",
      orElse: () => defaultPlanCategories.first);
  final productivityCategory = defaultPlanCategories.firstWhere(
      (cat) => cat.id == "productivity",
      orElse: () => defaultPlanCategories.first);
  final sleepCategory = defaultPlanCategories.firstWhere(
      (cat) => cat.id == "sleep",
      orElse: () => defaultPlanCategories.first);

  return [
    // Health & Wellness Category
    newHabitPlan(
      id: 'plan_health_morning_routine',
      title: 'Morning Health Routine',
      category: healthWellnessCategory,
      description: '''
A structured morning routine can set you up for success throughout the day. This plan combines hydration, movement, and nutrition to give your body what it needs first thing in the morning.

## Benefits

- **Improved Energy Levels**: Start your day with practices that energize your body
- **Better Metabolism**: Kickstart your metabolism for improved digestion throughout the day
- **Mental Clarity**: Set a positive tone for your day with mindful morning practices

## Scientific Background

Studies show that consistent morning habits can improve energy levels, metabolism, and overall wellbeing. Research published in the Journal of Physiology found that morning exercise can help regulate circadian rhythms and improve sleep quality.
''',
      imagePath: 'assets/images/plans/morning_routine.png',
      suggestions: _createHealthMorningSuggestions(),
    ),
    newHabitPlan(
      id: 'plan_stress_management',
      title: 'Stress Management',
      category: healthWellnessCategory,
      description: '''
Chronic stress can negatively impact both physical and mental health. This plan introduces evidence-based habits for managing stress through mindfulness, physical activity, and healthy boundaries.

## Key Benefits

- **Reduced Anxiety**: Learn techniques to calm your nervous system
- **Improved Focus**: Clear mental fog caused by chronic stress
- **Better Sleep**: Address stress-related sleep disturbances
- **Healthier Relationships**: Manage stress to improve interactions with others

## How It Works

By incorporating these habits into your routine, you can build resilience and improve your body's response to stressors. Each habit targets different aspects of stress management for a comprehensive approach.
''',
      imagePath: 'assets/images/plans/stress_management.png',
      suggestions: _createStressManagementSuggestions(),
    ),
    newHabitPlan(
      id: 'plan_better_sleep',
      title: 'Better Sleep',
      category: sleepCategory,
      description: '''
Quality sleep is essential for physical health, cognitive function, and emotional wellbeing. This plan focuses on habits that promote better sleep hygiene and establish a consistent sleep schedule.

## Benefits of Better Sleep

- **Improved Memory and Cognition**: Sleep helps consolidate memories and enhances learning
- **Stronger Immune Function**: Quality sleep supports your body's defense systems
- **Mood Regulation**: Sleep plays a critical role in emotional processing and stability
- **Weight Management**: Sleep affects hormones that regulate hunger and metabolism

## The Science

Research from the National Sleep Foundation indicates that consistent sleep habits can dramatically improve sleep quality. These practices help align your body's circadian rhythm and create optimal conditions for restorative sleep.
''',
      imagePath: 'assets/images/plans/better_sleep.png',
      suggestions: _createBetterSleepSuggestions(),
    ),

    // Productivity Category
    newHabitPlan(
      id: 'plan_deep_work',
      title: 'Deep Work Mastery',
      category: productivityCategory,
      description: '''
Deep work is the ability to focus without distraction on cognitively demanding tasks. This plan helps you develop habits that enhance concentration, reduce distractions, and create optimal conditions for high-quality work.

## Key Benefits

- **Increased Output Quality**: Produce better work through focused attention
- **Faster Completion**: Accomplish tasks more efficiently with fewer distractions
- **Greater Satisfaction**: Experience the fulfillment of deep engagement with your work
- **Skill Development**: Accelerate learning and mastery through deliberate practice

## Applied Techniques

Based on Cal Newport's research on knowledge work productivity, these habits establish boundaries that protect your cognitive resources and create systems for consistent deep work sessions.
''',
      imagePath: 'assets/images/plans/deep_work.png',
      suggestions: _createDeepWorkSuggestions(),
    ),

    newHabitPlan(
      id: 'plan_time_management',
      title: 'Effective Time Management',
      category: productivityCategory,
      description: '''
Good time management allows you to accomplish more in less time, reduce stress, and improve work-life balance. This plan introduces practices that help you prioritize tasks, minimize distractions, and make the most of your available time.

## Benefits

- **Reduced Overwhelm**: Clear systems for organizing priorities and tasks
- **Increased Productivity**: Focus on high-impact activities first
- **Better Work-Life Balance**: Create boundaries between work and personal time
- **Lower Stress Levels**: Eliminate the anxiety of disorganization

## Implementation Strategy

These habits build on time management research from productivity experts like David Allen (Getting Things Done) and Francesco Cirillo (The Pomodoro Technique), adapted for practical daily use.
''',
      imagePath: 'assets/images/plans/time_management.png',
      suggestions: _createTimeManagementSuggestions(),
    ),
  ];
}

// Helper methods to create suggestion lists for each plan

List<Suggestion> _createHealthMorningSuggestions() {
  final healthCategory =
      defaultCategories.firstWhere((cat) => cat.id == "health");

  return [
    newSuggestion(
      title: 'Morning Hydration',
      description:
          'Drink a glass of water right after waking up to rehydrate your body after sleep. Overnight, your body becomes dehydrated. Drinking water first thing in the morning rehydrates your body, kickstarts your metabolism, and helps flush out toxins.',
      habit: newHabit(
        userId: "user_placeholder",
        name: 'Morning Hydration',
        category: healthCategory,
        trackingType: TrackingType.progress,
        targetValue: 1,
        unit: "glass",
        reminderEnabled: true,
        repeatFrequency: RepeatFrequency.daily, // Use repeatFrequency directly
      ),
    ),
    newSuggestion(
      title: 'Morning Stretch',
      description:
          'Morning stretching improves blood circulation, increases flexibility, and helps your muscles prepare for the day. It also reduces stiffness from sleep and can improve your posture throughout the day.',
      habit: newHabit(
        userId: "user_placeholder",
        name: 'Morning Stretch',
        category: healthCategory,
        trackingType: TrackingType.complete,
        targetValue: 0,
        unit: "",
        reminderEnabled: true,
        repeatFrequency: RepeatFrequency.daily, // Use repeatFrequency directly
      ),
    ),
    newSuggestion(
      title: 'Nutritious Breakfast',
      description:
          'A healthy breakfast provides energy for the day, stabilizes blood sugar levels, and helps prevent overeating later. Including protein and fiber keeps you fuller longer and supports sustained energy release.',
      habit: newHabit(
        userId: "user_placeholder",
        name: 'Nutritious Breakfast',
        category: healthCategory,
        trackingType: TrackingType.complete,
        targetValue: 0,
        unit: "",
        reminderEnabled: true,
        repeatFrequency: RepeatFrequency.daily, // Use repeatFrequency directly
      ),
    ),
  ];
}

List<Suggestion> _createStressManagementSuggestions() {
  final healthCategory =
      _getCategory('Health', '#4CAF50', 'assets/icons/health.png');
  final mindfulnessCategory =
      _getCategory('Mindfulness', '#9C27B0', 'assets/icons/mindfulness.png');

  return [
    _createSuggestion(
      'Deep Breathing',
      'Deep, controlled breathing activates your parasympathetic nervous system, which controls your relaxation response. This simple practice can quickly reduce stress hormones and promote a sense of calm.',
      mindfulnessCategory,
      TrackingType.progress,
      2,
      'minutes',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'Physical Activity',
      'Exercise releases endorphins that act as natural mood elevators. Even short activity sessions can reduce stress hormones like adrenaline and cortisol while improving your overall sense of wellbeing.',
      healthCategory,
      TrackingType.progress,
      15,
      'minutes',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'Digital Detox',
      'Constant digital connectivity can increase stress levels through information overload and social comparison. Taking regular breaks from screens gives your mind time to reset and reduces mental fatigue.',
      mindfulnessCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
  ];
}

List<Suggestion> _createBetterSleepSuggestions() {
  final healthCategory =
      _getCategory('Health', '#4CAF50', 'assets/icons/health.png');

  return [
    _createSuggestion(
      'No screens before bed',
      'Blue light from screens suppresses melatonin, the hormone responsible for sleep. Establishing a screen-free period before bed helps your body naturally prepare for sleep and improves sleep quality.',
      healthCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'Consistent bedtime',
      'A regular sleep schedule strengthens your circadian rhythm – your body\'s internal clock. This helps you fall asleep faster and wake up more refreshed by aligning your sleep with your natural biological cycles.',
      healthCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'Bedroom environment',
      'Your sleep environment significantly affects sleep quality. Darkness signals sleep to your body, cooler temperatures help your core temperature drop (necessary for sleep), and quiet prevents disruptive awakenings.',
      healthCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
  ];
}

List<Suggestion> _createDeepWorkSuggestions() {
  final workCategory = _getCategory('Work', '#2196F3', 'assets/icons/work.png');

  return [
    _createSuggestion(
      'Focus Session',
      'Using time-blocking techniques like the Pomodoro method helps maximize concentration by working in defined intervals. This approach prevents burnout while maintaining high productivity during focused periods.',
      workCategory,
      TrackingType.progress,
      25,
      'minutes',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'No-phone time',
      'Even having your phone visible can reduce cognitive capacity, as your brain dedicates resources to resisting checking it. Physically removing this distraction allows for deeper mental engagement with your work.',
      workCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'Daily goals',
      'Identifying your highest-value tasks creates clarity and purpose for your workday. This practice helps you prioritize effectively and ensures you\'re making progress on significant projects regardless of interruptions.',
      workCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
  ];
}

List<Suggestion> _createTimeManagementSuggestions() {
  final workCategory = _getCategory('Work', '#2196F3', 'assets/icons/work.png');

  return [
    _createSuggestion(
      'Plan tomorrow',
      'Evening planning reduces decision fatigue the next day and creates a clear roadmap for immediate action. This practice also helps your brain relax by transferring tasks from mental storage to an external system.',
      workCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'Time blocking',
      'Time blocking transforms your calendar from a meeting schedule to a complete time management system. By assigning specific blocks for focused work, you protect your most valuable resource - your attention.',
      workCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.daily,
    ),
    _createSuggestion(
      'Weekly review',
      'A weekly review helps you process the past week\'s achievements and lessons, while strategically planning the week ahead. This higher-level planning ensures your daily activities align with your broader goals and priorities.',
      workCategory,
      TrackingType.complete,
      0,
      '',
      RepeatFrequency.weekly,
    ),
  ];
}

// Helper method to create a suggestion with a habit
Suggestion _createSuggestion(
  String name,
  String description,
  Category category,
  TrackingType trackingType,
  int targetValue,
  String unit,
  RepeatFrequency repeatFrequency,
) {
  String habitId = generateNewId('habit');

  // Create habit
  final habit = newHabit(
    id: habitId,
    userId: "user_123", // This would typically be replaced with actual user ID
    name: name,
    category: category,
    trackingType: trackingType,
    targetValue: targetValue,
    unit: unit,
    reminderEnabled: true,
    repeatFrequency: repeatFrequency,
  );

  // Create and return suggestion with habit
  return newSuggestion(
    title: name,
    description: description,
    habit: habit,
  );
}

// Helper method to create a habit category
Category _getCategory(String name, String colorHex, String iconPath) {
  return Category((b) => b
    ..id = generateNewId('category_$name'.toLowerCase().replaceAll(' ', '_'))
    ..name = name
    ..colorHex = colorHex
    ..iconPath = iconPath);
}

// Add this to your SuggestionController class
Future<List<Suggestion>> loadMockSuggestions() async {
  // Simulate loading delay
  await Future.delayed(const Duration(seconds: 1));

  // Sample category data
  final healthCategory = Category((b) => b
    ..id = "category_1"
    ..name = "Health"
    ..colorHex = "#4CAF50"
    ..iconPath = "assets/icons/health.png");

  final educationCategory = Category((b) => b
    ..id = "category_4"
    ..name = "Education"
    ..colorHex = "#FFC107"
    ..iconPath = "assets/icons/education.png");

  // Generate fake suggestions
  return [
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Morning Meditation"
      ..description =
          "Starting your day with a 10-minute meditation has been shown to reduce stress and improve focus. Based on your sleep pattern, this would be most effective right after waking up."
      ..habit = Habit((h) => h
        ..id = generateNewId('habit')
        ..name = "Morning Meditation"
        ..userId = "user_123"
        ..category = healthCategory.toBuilder()
        ..trackingType = TrackingType.progress
        ..targetValue = 10
        ..unit = "minutes"
        ..reminderEnabled = true
        ..series = HabitSeries((s) => s
          ..id = generateNewId('series')
          ..userId = "user_123"
          ..habitId = generateNewId('habit')
          ..repeatFrequency = RepeatFrequency.daily
          ..startDate = DateTime.now().toUtc()).toBuilder()).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Daily Reading"
      ..description =
          "Regular reading improves cognitive function and reduces stress. Based on your habits, setting aside 20 minutes before bed could help you build this habit."
      ..habit = Habit((h) => h
        ..id = generateNewId('habit')
        ..name = "Daily Reading"
        ..userId = "user_123"
        ..category = educationCategory.toBuilder()
        ..trackingType = TrackingType.progress
        ..targetValue = 20
        ..unit = "minutes"
        ..reminderEnabled = true
        ..series = HabitSeries((s) => s
          ..id = generateNewId('series')
          ..userId = "user_123"
          ..habitId = generateNewId('habit')
          ..repeatFrequency = RepeatFrequency.daily
          ..startDate = DateTime.now().toUtc()).toBuilder()).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Drink Water"
      ..description =
          "Staying hydrated improves energy levels and cognitive function. Aim for 8 glasses of water throughout the day."
      ..habit = Habit((h) => h
        ..id = generateNewId('habit')
        ..name = "Drink Water"
        ..userId = "user_123"
        ..category = healthCategory.toBuilder()
        ..trackingType = TrackingType.progress
        ..targetValue = 8
        ..unit = "glasses"
        ..reminderEnabled = true
        ..series = HabitSeries((s) => s
          ..id = generateNewId('series')
          ..userId = "user_123"
          ..habitId = generateNewId('habit')
          ..repeatFrequency = RepeatFrequency.daily
          ..startDate = DateTime.now().toUtc()).toBuilder()).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Exercise Break"
      ..description =
          "Taking short movement breaks during work improves circulation and reduces the negative effects of sitting. We suggest a 5-minute activity every 2 hours."
      ..habit = Habit((h) => h
        ..id = generateNewId('habit')
        ..name = "Exercise Break"
        ..userId = "user_123"
        ..category = healthCategory.toBuilder()
        ..trackingType = TrackingType.complete
        ..targetValue = 0
        ..unit = ""
        ..reminderEnabled = true
        ..series = HabitSeries((s) => s
          ..id = generateNewId('series')
          ..userId = "user_123"
          ..habitId = generateNewId('habit')
          ..repeatFrequency = RepeatFrequency.daily
          ..startDate = DateTime.now().toUtc()).toBuilder()).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Focus Time"
      ..description =
          "Scheduling dedicated focus time without distractions can significantly boost productivity. We recommend starting with 25-minute focused work sessions."
      ..habit = Habit((h) => h
        ..id = generateNewId('habit')
        ..name = "Focus Time"
        ..userId = "user_123"
        ..category = healthCategory.toBuilder()
        ..trackingType = TrackingType.progress
        ..targetValue = 25
        ..unit = "minutes"
        ..reminderEnabled = true
        ..series = HabitSeries((s) => s
          ..id = generateNewId('series')
          ..userId = "user_123"
          ..habitId = generateNewId('habit')
          ..repeatFrequency = RepeatFrequency.daily
          ..startDate = DateTime.now().toUtc()).toBuilder()).toBuilder()),
    Suggestion((b) => b
      ..id = generateNewId('suggestion')
      ..title = "Gratitude Journal"
      ..description =
          "Writing down things you're grateful for has been shown to increase happiness and well-being. Try listing 3 things each evening."
      ..habit = Habit((h) => h
        ..id = generateNewId('habit')
        ..name = "Gratitude Journal"
        ..userId = "user_123"
        ..category = healthCategory.toBuilder()
        ..trackingType = TrackingType.complete
        ..targetValue = 0
        ..unit = ""
        ..reminderEnabled = true
        ..series = HabitSeries((s) => s
          ..id = generateNewId('series')
          ..userId = "user_123"
          ..habitId = generateNewId('habit')
          ..repeatFrequency = RepeatFrequency.daily
          ..startDate = DateTime.now().toUtc()).toBuilder()).toBuilder()),
  ];
}
