import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'habit.dart';

part 'suggestion.g.dart';

abstract class Suggestion implements Built<Suggestion, SuggestionBuilder> {
  String get id;

  String get title;

  String get description;

  Habit? get habit;

  Suggestion._();
  factory Suggestion([void Function(SuggestionBuilder) updates]) = _$Suggestion;

  factory Suggestion.fromJson(Map<String, dynamic> json) =>
      serializers.deserializeWith(Suggestion.serializer, json)!;

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(Suggestion.serializer, this)
          as Map<String, dynamic>;

  static Serializer<Suggestion> get serializer => _$suggestionSerializer;
}
