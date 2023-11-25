class HealthDataEntry {
  double value;
  DateTime createdAt;
  HealthDataEntry({
    required this.value,
    required this.createdAt,
  });

  HealthDataEntry copyWith({
    double? value,
    DateTime? createdAt,
  }) {
    return HealthDataEntry(
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'HealthDataEntry(value: $value, createdAt: $createdAt)';

  @override
  bool operator ==(covariant HealthDataEntry other) {
    if (identical(this, other)) return true;

    return other.value == value && other.createdAt == createdAt;
  }

  @override
  int get hashCode => value.hashCode ^ createdAt.hashCode;
}
