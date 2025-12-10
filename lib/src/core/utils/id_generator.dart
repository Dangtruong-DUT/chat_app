class IDGenerator {
  IDGenerator._();

  static String generator() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
