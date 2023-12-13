// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2String = await task2();
  task3(task2String);
}

void task1() {
  String result = 'task 1 data';
  if (kDebugMode) {
    print('Task 1 complete');
  }
}

Future<String> task2() {
  Duration threeSecond = const Duration(seconds: 3);
  return Future.delayed(threeSecond, () {
    if (kDebugMode) {
      print('Task 2 complete');
    }
    return 'task 2 data';
  });
}

void task3(String task2String) {
  String result = 'task 3 data';
  if (kDebugMode) {
    print('Task 3 complete with $task2String');
  }
}

bool isAlpha(String str) {
  return str.isNotEmpty && !str.contains(RegExp(r'[^a-zA-Z]'));
}
