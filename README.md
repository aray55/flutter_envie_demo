# Flutter Envied Demo

A complete Flutter example showcasing the **envied** package for secure, typed environment configuration across build flavors.

## 🎯 Features

- **Type-safe environment variables** with compile-time validation
- **Obfuscated sensitive values** (Sentry DSN) for security
- **Multi-flavor support** (dev/staging/prod) with different configurations
- **Beautiful demo UI** showcasing all environment variables
- **Code generation** with build_runner for seamless integration

## 🏗️ Architecture

```
lib/
├── env/
│   ├── app_config.dart      # Environment configuration classes
│   └── app_config.g.dart    # Generated obfuscated code
├── core/
│   └── flavor_manager.dart  # Flavor initialization logic
├── features/
│   └── demo/
│       └── env_demo_page.dart # Demo UI showcasing env vars
└── main.dart                # App entry point
```

## 🚀 Quick Start

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Set Up Environment Files

Copy the example files and customize them:

```bash
cp .env.dev.example .env.dev
cp .env.staging.example .env.staging
cp .env.prod.example .env.prod
```

### 3. Generate Code

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run the App

**Development:**
```bash
flutter run --dart-define=FLAVOR=dev
```

**Staging:**
```bash
flutter run --dart-define=FLAVOR=staging
```

**Production:**
```bash
flutter run --dart-define=FLAVOR=prod
```

## 📱 Demo UI Features

The demo app displays:

- **Current flavor** with color-coded banner
- **All environment variables** in a clean interface
- **Obfuscated sensitive data** (Sentry DSN is hidden)
- **Interactive actions** (copy API URL, show config details)
- **Flavor-specific styling** (green=dev, orange=staging, red=prod)

## 🔒 Security Features

### Obfuscation
Sensitive values like `SENTRY_DSN` are obfuscated using XOR encryption:

```dart
@EnviedField(varName: 'SENTRY_DSN', obfuscate: true)
static const String sentryDsn = _DevConfig.sentryDsn;
```

The generated code contains encrypted arrays instead of plain text:
```dart
static const List<int> _enviedkeysentryDsn = <int>[2324250691, 4067843059, ...];
static const List<int> _envieddatasentryDsn = <int>[2324250667, 4067842951, ...];
```

### Type Safety
All environment variables are strongly typed:
- `String` for URLs and names
- `bool` for debug flags
- Compile-time validation prevents runtime errors

## 🛠️ Development Workflow

### Adding New Environment Variables

1. **Add to .env files:**
```bash
# .env.dev
NEW_VARIABLE=dev_value
```

2. **Update AppConfig:**
```dart
@EnviedField(varName: 'NEW_VARIABLE')
static const String newVariable = _DevConfig.newVariable;
```

3. **Regenerate code:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Flavor Management

The app automatically detects the flavor from `--dart-define=FLAVOR=<flavor>`:

```dart
// FlavorManager.initializeFlavor() reads FLAVOR and sets:
AppConfig.setFlavor(AppFlavor.dev);    // for FLAVOR=dev
AppConfig.setFlavor(AppFlavor.staging); // for FLAVOR=staging  
AppConfig.setFlavor(AppFlavor.prod);    // for FLAVOR=prod
```

## 📦 Dependencies

- **[envied](https://pub.dev/packages/envied)**: Type-safe environment variables
- **[envied_generator](https://pub.dev/packages/envied_generator)**: Code generation
- **[build_runner](https://pub.dev/packages/build_runner)**: Build system

## 🎨 UI Components

### Flavor Banner
- **Color-coded** by environment (green/orange/red)
- **Icon representation** (code/build/rocket)
- **Version display** with flavor-specific versioning

### Configuration Display
- **Organized sections** for different types of config
- **Monospace font** for technical values
- **Security indicators** for obfuscated data

### Interactive Actions
- **Copy to clipboard** functionality
- **Modal dialogs** with detailed information
- **Responsive design** for different screen sizes

## 🔧 Troubleshooting

### Code Generation Issues
```bash
# Clean and regenerate
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Missing Environment Files
Ensure all `.env.*` files exist and contain required variables:
- `API_BASE_URL`
- `DEBUG`
- `SENTRY_DSN`
- `APP_NAME`
- `VERSION`

### Flavor Not Detected
Make sure to pass the flavor parameter:
```bash
flutter run --dart-define=FLAVOR=dev
```

## 📚 Learn More

- [Envied Package Documentation](https://pub.dev/packages/envied)
- [Flutter Build Flavors](https://docs.flutter.dev/deployment/flavors)
- [Code Generation in Dart](https://dart.dev/guides/libraries/code-generation)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Add tests for new functionality
4. Ensure code generation works
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
