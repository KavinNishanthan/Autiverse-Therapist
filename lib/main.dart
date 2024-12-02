import 'package:flutter/material.dart';
import 'package:autiverse/routes/app_routes.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autiverse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(surface: Colors.white),
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
