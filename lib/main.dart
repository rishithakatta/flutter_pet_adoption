import 'package:flutter/material.dart';
import 'package:petadoptionapp/gettingstartedscreen.dart';
import 'package:petadoptionapp/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AdoptedPetsProvider(),
    child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:'Pet App',
      debugShowCheckedModeBanner: false,
      home: GettingStartedScreen(),
    );
  }
}