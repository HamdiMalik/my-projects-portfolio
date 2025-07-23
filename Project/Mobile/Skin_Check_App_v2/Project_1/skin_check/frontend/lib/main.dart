import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skincheck/providers/auth_provider.dart';
import 'package:skincheck/providers/scan_provider.dart';
import 'package:skincheck/providers/notification_provider.dart';
import 'package:skincheck/screens/splash_screen.dart';
import 'package:skincheck/utils/theme.dart';
import 'package:skincheck/services/api_service.dart';

void main() {
  runApp(const SkinCheckApp());
}

class SkinCheckApp extends StatelessWidget {
  const SkinCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'SkinCheck',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}