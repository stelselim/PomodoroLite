import 'dart:convert';

class Pomodoro {
  int breakMinute; // Break Minute
  int workSessionMinute; // Work Session's Minute
  bool isWorkTime; // Work Time Or Break Time
  int rounds; // Work Round

  Pomodoro({
    this.breakMinute = 5,
    this.workSessionMinute = 25,
    this.isWorkTime = true,
    this.rounds = 4,
  });

  Map<String, dynamic> toMap() {
    return {
      'breakMinute': breakMinute,
      'workSessionMinute': workSessionMinute,
      'isWorkTime': isWorkTime,
      'rounds': rounds,
    };
  }

  factory Pomodoro.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Pomodoro(
      breakMinute: map['breakMinute'],
      workSessionMinute: map['workSessionMinute'],
      isWorkTime: map['isWorkTime'],
      rounds: map['rounds'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Pomodoro.fromJson(String source) =>
      Pomodoro.fromMap(json.decode(source));

  Pomodoro copyWith({
    int breakMinute,
    int workSessionMinute,
    bool isWorkTime,
    int rounds,
  }) {
    return Pomodoro(
      breakMinute: breakMinute ?? this.breakMinute,
      workSessionMinute: workSessionMinute ?? this.workSessionMinute,
      isWorkTime: isWorkTime ?? this.isWorkTime,
      rounds: rounds ?? this.rounds,
    );
  }

  @override
  String toString() {
    return 'Pomodoro(breakMinute: $breakMinute, workSessionMinute: $workSessionMinute, isWorkTime: $isWorkTime, rounds: $rounds)';
  }
}
