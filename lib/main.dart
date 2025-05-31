import 'package:capture/screens/Splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:capture/database/like_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 카카오 초기화
  KakaoSdk.init(nativeAppKey: '45d50b632429ae9a61b47c8444795cdb');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LikeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const SafeArea(
        child: Center(child: Text('Hello, Flutter!')),
      ),
    );
  }
}
