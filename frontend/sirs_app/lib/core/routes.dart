import 'package:flutter/material.dart';
import '../views/home/home_screen.dart';
import '../views/report/report_screen.dart';
import '../views/history/report_history_screen.dart';
import '../views/profile/profile_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const HomeScreen(),
  '/report': (context) => const ReportScreen(),
  '/history': (context) => const ReportHistoryScreen(),
  '/profile': (context) => const ProfileScreen(),
};
