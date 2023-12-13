// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api/firebase_message.dart';
import 'api/local_notification.dart';
import 'controllers/mainscreen_provider.dart';
import 'firebase_options.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessage().initNotification();

  LocalNotificationServices.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainScreenNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Messaging App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: MainScreen(),
      ),
    );
  }
}
