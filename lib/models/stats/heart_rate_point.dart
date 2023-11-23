class HearthRatePoint {
  double value;
  DateTime createdAt;
  HearthRatePoint({
    required this.value,
    required this.createdAt,
  });

  HearthRatePoint copyWith({
    double? value,
    DateTime? createdAt,
  }) {
    return HearthRatePoint(
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() => 'HearthRatePoint(value: $value, createdAt: $createdAt)';

  @override
  bool operator ==(covariant HearthRatePoint other) {
    if (identical(this, other)) return true;

    return other.value == value && other.createdAt == createdAt;
  }

  @override
  int get hashCode => value.hashCode ^ createdAt.hashCode;
}
