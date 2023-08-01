class AppConfig {
  //? Global Attributte
  static const bool debug = true;
  static const bool production = false;

  //? Config API
  static const String appsVersionAndroid = "v1.0.0";
  static const String appsversionIos = "v1.0.0";
  static const String cacheControl = "no-cache";
  static const String contentType = "application/json";

  static const int durationShimmer = 1200;
  static const Duration timeRequestApi = Duration(minutes: 1);

  static const poppinsRegular = "poppins_regular";
}
