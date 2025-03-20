import 'package:built_value/serializer.dart';

class MillisecondsSinceEpochDateTimeSerializer
    implements PrimitiveSerializer<DateTime> {
  @override
  final Iterable<Type> types = const [DateTime];
  @override
  final String wireName = 'DateTime';

  @override
  Object serialize(Serializers serializers, DateTime dateTime,
      {FullType specifiedType = FullType.unspecified}) {
    return dateTime.millisecondsSinceEpoch;
  }

  @override
  DateTime deserialize(Serializers serializers, Object serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return DateTime.fromMillisecondsSinceEpoch(serialized as int, isUtc: true);
  }
}
