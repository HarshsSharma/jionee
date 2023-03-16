extension StringsExtension on String? {
  bool isNumeric() {
    if (this == null) {
      return false;
    }
    return double.tryParse(this!) != null;
  }

  String lastChar() {
    return this![this!.length - 1];
  }
}
