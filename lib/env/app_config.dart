import 'package:envied/envied.dart';

part 'app_config.g.dart';

@Envied(path: '.env.dev')
abstract class DevConfig {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _DevConfig.apiBaseUrl;
  
  @EnviedField(varName: 'DEBUG')
  static const bool debug = _DevConfig.debug;
  
  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _DevConfig.sentryDsn;
  
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _DevConfig.appName;
  
  @EnviedField(varName: 'VERSION')
  static const String version = _DevConfig.version;
}

@Envied(path: '.env.staging')
abstract class StagingConfig {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _StagingConfig.apiBaseUrl;
  
  @EnviedField(varName: 'DEBUG')
  static const bool debug = _StagingConfig.debug;
  
  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _StagingConfig.sentryDsn;
  
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _StagingConfig.appName;
  
  @EnviedField(varName: 'VERSION')
  static const String version = _StagingConfig.version;
}

@Envied(path: '.env.prod')
abstract class ProdConfig {
  @EnviedField(varName: 'API_BASE_URL')
  static const String apiBaseUrl = _ProdConfig.apiBaseUrl;
  
  @EnviedField(varName: 'DEBUG')
  static const bool debug = _ProdConfig.debug;
  
  @EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
  static final String sentryDsn = _ProdConfig.sentryDsn;
  
  @EnviedField(varName: 'APP_NAME')
  static const String appName = _ProdConfig.appName;
  
  @EnviedField(varName: 'VERSION')
  static const String version = _ProdConfig.version;
}

enum AppFlavor { dev, staging, prod }

class AppConfig {
  static AppFlavor _flavor = AppFlavor.dev;
  
  static AppFlavor get flavor => _flavor;
  
  static void setFlavor(AppFlavor flavor) {
    _flavor = flavor;
  }
  
  static String get apiBaseUrl {
    switch (_flavor) {
      case AppFlavor.dev:
        return DevConfig.apiBaseUrl;
      case AppFlavor.staging:
        return StagingConfig.apiBaseUrl;
      case AppFlavor.prod:
        return ProdConfig.apiBaseUrl;
    }
  }
  
  static bool get debug {
    switch (_flavor) {
      case AppFlavor.dev:
        return DevConfig.debug;
      case AppFlavor.staging:
        return StagingConfig.debug;
      case AppFlavor.prod:
        return ProdConfig.debug;
    }
  }
  
  static String get sentryDsn {
    switch (_flavor) {
      case AppFlavor.dev:
        return DevConfig.sentryDsn;
      case AppFlavor.staging:
        return StagingConfig.sentryDsn;
      case AppFlavor.prod:
        return ProdConfig.sentryDsn;
    }
  }
  
  static String get appName {
    switch (_flavor) {
      case AppFlavor.dev:
        return DevConfig.appName;
      case AppFlavor.staging:
        return StagingConfig.appName;
      case AppFlavor.prod:
        return ProdConfig.appName;
    }
  }
  
  static String get version {
    switch (_flavor) {
      case AppFlavor.dev:
        return DevConfig.version;
      case AppFlavor.staging:
        return StagingConfig.version;
      case AppFlavor.prod:
        return ProdConfig.version;
    }
  }
  
  static String get flavorName => _flavor.name;
  
  static bool get isProduction => _flavor == AppFlavor.prod;
  static bool get isDevelopment => _flavor == AppFlavor.dev;
  static bool get isStaging => _flavor == AppFlavor.staging;
}
