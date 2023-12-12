import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:price_alert/screens/dashboard_screen.dart';
import 'firebase_options.dart';
import 'api/firebase_message.dart';
import 'screens/home_screen.dart';
import 'screens/register_login_screen.dart';
import 'api/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessage().initNotification();
  LocalNotificationServices.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Messaging App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/register_screen': (context) => RegisterScreen(),
        '/dashboard_screen': (context) => DashBoard(),
      },
    );
  }
}
