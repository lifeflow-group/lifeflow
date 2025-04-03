import 'package:built_value/serializer.dart';

class FlexibleDateTimeSerializer implements PrimitiveSerializer<DateTime> {
  @override
  final Iterable<Type> types = const [DateTime];
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType = FullType.unspecified}) {
    return dateTime.toUtc().millisecondsSinceEpoch;
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    if (serialized is int) {
      return DateTime.fromMillisecondsSinceEpoch(serialized,
          isUtc: true); // Parse from timestamp
    } else if (serialized is String) {
      return DateTime.parse(serialized).toUtc(); // Parse from ISO 8601 string
    }
    throw ArgumentError('Invalid DateTime format: $serialized');
  }
}
