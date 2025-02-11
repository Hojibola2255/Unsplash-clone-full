import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo16/blocs/collection/collection_bloc.dart';
import 'package:ngdemo16/blocs/home/home_bloc.dart';
import 'package:ngdemo16/pages/collection_page.dart';
import 'package:ngdemo16/pages/home_page.dart';



void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // faqat ishlab chiqish rejimida yoqiladi
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: HomePage(),
      ),
    );
  }
}
