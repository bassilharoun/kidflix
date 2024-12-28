import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidflix_app/domain/models/user_model.dart';

class TimeCheckCubit extends Cubit<bool> {
  TimeCheckCubit() : super(true); // Initially accessible

  Timer? _timer;

  // Update the method to accept List<UserTimeActive>
  void startChecking(List<UserTimeActive> userTimeActiveList) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _checkAccess(userTimeActiveList);
    });
    _checkAccess(userTimeActiveList); // Run immediately when called
  }

  void _checkAccess(List<UserTimeActive> userTimeActiveList) {
    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    bool isAccessible = false;
    if (userTimeActiveList.isEmpty) {
      isAccessible = true;
    } else {
      for (var accessTime in userTimeActiveList) {
        final startTime = _parseTime(accessTime.start);
        final endTime = _parseTime(accessTime.end);

        if (_isTimeInRange(currentTime, startTime, endTime)) {
          isAccessible = true;
          break;
        }
      }
    }

    emit(isAccessible); // Update the access state
    debugPrint('Access: ${userTimeActiveList}');
    debugPrint('Access: $isAccessible');
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  bool _isTimeInRange(TimeOfDay current, TimeOfDay start, TimeOfDay end) {
    final currentMinutes = current.hour * 60 + current.minute;
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    return currentMinutes >= startMinutes && currentMinutes <= endMinutes;
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
