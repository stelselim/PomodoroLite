import 'dart:convert';

class Pomodoro {
  int breakMinute; // Break Minute
  int workSessionMinute; // Work Session's Minute
  int round; // Work Round

  Pomodoro({
    this.breakMinute = 5,
    this.workSessionMinute = 25,
    this.round = 5,
  });

  Map<String, dynamic> toMap() {
    return {
      'breakMinute': breakMinute,
      'workSessionMinute': workSessionMinute,
      'round': round,
    };
  }

  factory Pomodoro.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Pomodoro(
      breakMinute: map['breakMinute'],
      workSessionMinute: map['workSessionMinute'],
      round: map['round'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Pomodoro.fromJson(String source) =>
      Pomodoro.fromMap(json.decode(source));

  Pomodoro copyWith({
    int breakMinute,
    int workSessionMinute,
    int round,
  }) {
    return Pomodoro(
      breakMinute: breakMinute ?? this.breakMinute,
      workSessionMinute: workSessionMinute ?? this.workSessionMinute,
      round: round ?? this.round,
    );
  }

  @override
  String toString() =>
      'Pomodoro(breakMinute: $breakMinute, workSessionMinute: $workSessionMinute, round: $round)';
}
