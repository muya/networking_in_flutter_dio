import 'package:flutter/material.dart';
import 'package:networking_in_flutter_dio/themes/color_schemes.g.dart';
import 'package:networking_in_flutter_dio/ui/home/controller.dart';
import 'package:networking_in_flutter_dio/ui/home/home_page.dart';
import 'package:networking_in_flutter_dio/di/service_locator.dart';
import 'package:provider/provider.dart';

void main() {
  setup();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<HomeController>(
        create: (_) => HomeController(),
      )
    ], child: const MyApp(),)
  );
  
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking in Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
