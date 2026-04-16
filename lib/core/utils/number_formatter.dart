class NumberFormatter {
  const NumberFormatter._();

  static String money(double value) => value.toStringAsFixed(2);

  static String number(double value) => value.toStringAsFixed(2);
}
