# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Camera plugin
-keep class io.flutter.plugins.camera.** { *; }

# Image picker plugin
-keep class io.flutter.plugins.imagepicker.** { *; }

# Shared preferences plugin
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# Path provider plugin
-keep class io.flutter.plugins.pathprovider.** { *; }

# Permission handler plugin
-keep class com.baseflow.permissionhandler.** { *; }

# Connectivity plugin
-keep class com.baseflow.connectivity.** { *; }

# HTTP plugin
-keep class io.flutter.plugins.urllauncher.** { *; }

# Secure storage plugin
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# SQLite plugin
-keep class com.tekartik.sqflite.** { *; }

# General Android rules
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}