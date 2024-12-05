import 'package:flutter/material.dart';
import 'package:autiverse/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:autiverse/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // User state management
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Autiverse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(surface: Colors.white),
        ),
        initialRoute: '/', // Set your initial route here
        routes: AppRoutes.routes, // Define your app routes in a separate file
      ),
    );
  }
}
