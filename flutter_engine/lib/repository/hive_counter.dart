import 'package:hive/hive.dart';

part 'hive_counter.g.dart';

@HiveType(typeId: 0)
class HiveCounter extends HiveObject {
  @HiveField(0)
  int value;

  HiveCounter({required this.value});
}
