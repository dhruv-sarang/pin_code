import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pin_code/routing/app_route.dart';

import 'constant/app_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDbrTdmOzwzBb2j60fXeNKez--afnUHZHg",
          appId: "1:876188091041:android:91ef9efa173137143866e0",
          messagingSenderId: "876188091041",
          projectId: "pin-code-d6c26",
          storageBucket: "pin-code-d6c26.appspot.com"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Code App',
      initialRoute: AppConstant.splashScreen,
      onGenerateRoute: AppRoute.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
