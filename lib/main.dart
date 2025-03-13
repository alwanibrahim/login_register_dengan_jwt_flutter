import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image/screens/register_page.dart';
import 'package:provider/provider.dart';
import 'package:image/provider/provider_auth.dart';
import 'package:image/provider/task_provider.dart';
import 'package:image/screens/home_page.dart';
import 'package:image/screens/login_page.dart';
import 'package:image/api/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ✅ Pastikan binding Flutter diinisialisasi
  await dotenv.load(fileName: ".env"); // ✅ Load variabel lingkungan

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProvider()), // ✅ Provider untuk autentikasi
        ChangeNotifierProvider(
            create: (_) =>
                TaskProvider()..fetchTasks()), // ✅ Provider untuk task
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Login',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginForm(),
          '/home': (context) => HomePage(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}
