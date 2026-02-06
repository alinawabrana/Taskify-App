import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/data/routes/go_routes.dart';
import 'package:taskify/data/services/shared_preferences_service.dart';
import 'package:taskify/features/authentication/screens/login/login_screen.dart';
import 'package:taskify/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing and loading SharedPreferences
  await SharedPreferencesService.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      //Adding Light and Dark Mode Themes to app
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,

      routerConfig: AGoRouters().router,
    );
  }
}
