# mobile_listing_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Demonstrate the memory management and image cache optimization technique

Assume you have a network image with a resolution of 2200 X 1800 and a size of approximately 8MB. In your application, however, you only want to show a thumbnail version of it in a constrainedBox with height and width of 100px. The original image dimensions are very huge for our needs here.

Flutter Image Renderer works by caching the full-resolution image in memory and taking up the entire 8MB image size space. Consider displaying a list of 300 such images, and the total memory adds up to 2.4GB, which is enough to cause your app to crash on iOS 15, which has a memory heap limit of 2098MBs.

This problem can be solved by adding cache height and cache width. For example, if a responsive widget has a maximum size of 200 X 150, appropriate cache parameters must be given. The flutter rendered then just caches the image's specific resolution, regardless of the original size. 

eg:
```
Image.network("url",cacheHeight:140,cacheWidth:140),

```



## Development Environment
`flutter doctor -v`
```
[✓] Flutter (Channel stable, 3.10.5, on macOS 13.4.1 22F770820d darwin-arm64, locale en-IN)
    • Flutter version 3.10.5 on channel stable at /Applications/development/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 796c8ef792 (6 weeks ago), 2023-06-13 15:51:02 -0700
    • Engine revision 45f6e00911
    • Dart version 3.0.5
    • DevTools version 2.23.1

[✓] Android toolchain - develop for Android devices (Android SDK version 32.0.0)
    • Android SDK at /Users/avinashjindal/Library/Android/sdk
    • Platform android-34, build-tools 32.0.0
    • Java binary at: /Applications/Android Studio.app/Contents/jre/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 11.0.13+0-b1751.21-8125866)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 14.3.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 14E300c
    • CocoaPods version 1.12.1

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2021.3)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 11.0.13+0-b1751.21-8125866)

[✓] VS Code (version 1.80.1)
    • VS Code at /Applications/Visual Studio Code 2.app/Contents
    • Flutter extension version 3.68.0

[✓] Connected device (3 available)
    • sdk gphone64 arm64 (mobile) • emulator-5554 • android-arm64  • Android 12 (API 31) (emulator)
    • macOS (desktop)             • macos         • darwin-arm64   • macOS 13.4.1 22F770820d darwin-arm64
    • Chrome (web)                • chrome        • web-javascript • Google Chrome 114.0.5735.248

[✓] Network resources
    • All expected network resources are available.
```

Before run project, execute commands:
- `flutter clean`
- `flutter pub get`
- `flutter pub run build_runner build` or `flutter pub run build_runner build --delete-conflicting-outputs`
- `flutter run` (if needed)