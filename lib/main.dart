import 'dart:developer';
import 'dart:ui';

import 'package:dyslexia_assistant/screens/home.dart';
import 'package:dyslexia_assistant/screens/overlay_screen.dart';
import 'package:dyslexia_assistant/services/ocr_services.dart';
import 'package:dyslexia_assistant/services/speech_confirm_send.dart';
import 'package:dyslexia_assistant/widgets/activity_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

const platform = MethodChannel('samples.flutter.dev/battery');

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance!.addPostFrameCallback((_) async {
    try {
      //await ScreenCapture.captureScreen();
      Map<Permission, PermissionStatus> status = await [
        Permission.camera,
        Permission.storage,
      ].request();

      if(status[Permission.camera]  == PermissionStatus.granted && status[Permission.storage] == PermissionStatus.granted){
        print('UCOKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK');
      }
      final res = await FlutterNativeScreenshot.takeScreenshot();
      final startService = await FlutterNativeScreenshot.startService();


      print('res aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa $res');
      print(startService);



      print('WADUH BROOOO');
      //print('Screenshot tersimpan: ${imageFile.}');
    } catch (e) {
      print('error: $e');
    }

  });
  runApp(ProviderScope(child: MyApp()));
}
// overlay entry point
@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  runApp(ProviderScope(child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        color: Colors.transparent,
        child: ActivityDetector(child: OverlayScreen(),),
      )
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  App(title: 'Flutter Demo Home Page'),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SpeechConfirmToSend();
    print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
   // doSomething();
    print('HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH');
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return   MaterialApp(
      title: 'Dysistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ActivityDetector(child: Home())
      },
    );
  }
}
