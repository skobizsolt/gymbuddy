import 'dart:io';

class WorkoutImage {
  String? fileName;
  File file;
  WorkoutImage({
    this.fileName,
    required this.file,
  });

  WorkoutImage copyWith({
    String? fileName,
    File? file,
  }) {
    return WorkoutImage(
      fileName: fileName ?? this.fileName,
      file: file ?? this.file,
    );
  }

  @override
  String toString() => 'WorkoutImage(fileName: $fileName, file: $file)';

  @override
  bool operator ==(covariant WorkoutImage other) {
    if (identical(this, other)) return true;

    return other.fileName == fileName && other.file == file;
  }

  @override
  int get hashCode => fileName.hashCode ^ file.hashCode;
}
