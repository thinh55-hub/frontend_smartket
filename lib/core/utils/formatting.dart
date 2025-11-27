String formatCurrency(num value, {String separator = '.'}) {
  final digits = value.toInt().toString();
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);
    final remaining = digits.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write(separator);
    }
  }
  return buffer.toString();
}
