import 'package:flutter_engine/repository/hive_counter.dart';
import 'package:hive/hive.dart';

class HiveRepository {
  saveCounter(int value) async {
    var box = await Hive.openBox('hiveRepository');
    var counter = HiveCounter(value: value);

    try {
      await box.putAt(0, counter);
    } catch (e) {
      await box.add(counter);
    }
  }

  Future<int> loadCounter() async {
    var box = await Hive.openBox('hiveRepository');
    return ((await box.getAt(0)) as HiveCounter).value;
  }
}
