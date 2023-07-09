import 'package:absensi_smk_bp/commons/globals.dart';
import 'package:absensi_smk_bp/hive_models/profile_hive_model.dart';
import 'package:absensi_smk_bp/models/leave.dart';
import 'package:absensi_smk_bp/screens/attendance/leave_history_detail_screen.dart';
import 'package:absensi_smk_bp/screens/home_screen.dart';
import 'package:absensi_smk_bp/screens/leave/leave_request.dart';
import 'package:absensi_smk_bp/screens/login_screen.dart';
import 'package:absensi_smk_bp/screens/profile/edit_profile.dart';
import 'package:absensi_smk_bp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProfileHiveModelAdapter());
  initializeDateFormatting('id_id', null);

  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => EditProfileScreen(),
    ),
    GoRoute(
      path: '/leave-history-detail',
      builder: (context, state) {
        return LeaveHistoryDetailScreen(leave: state.extra as Leave);
      },
    ),
    GoRoute(
      path: '/leave-request',
      builder: (context, state) {
        return LeaveRequestScreen(state.extra as int);
      },
    ),
  ],
  initialLocation: '/',
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final appTitle = 'Absensi Guru SMK Bina Putra';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFfafafa),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
