class EnvConfig {
  EnvConfig._();

  // In Android emulator, host machine localhost is 10.0.2.2
  static const String devBaseUrl = 'http://10.0.2.2:5003/api';
  // TODO: Replace with real production URL
  static const String prodBaseUrl = 'https://api.smartket.example.com/api';

  static String get baseUrl => _mode == EnvMode.production ? prodBaseUrl : devBaseUrl;

  static EnvMode _mode = EnvMode.development;
  static void setMode(EnvMode mode) => _mode = mode;
}

enum EnvMode { development, production }